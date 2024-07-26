data "newrelic_entity" "appp" {
  name = "apm-NR"
  domain = "APM"
  type = "Application"
}

resource "newrelic_alert_policy" "policy-relicstaurant" {
  name = "policy-relicstaurant"
}


resource "newrelic_nrql_alert_condition" "foo" {
  account_id                     = 4510907
  policy_id                      = newrelic_alert_policy.policy-relicstaurant.id

  type                           = "static"
  name                           = "condition-relicstaurants"
  description                    = "Alert when transactions are taking too long"
  //runbook_url                    = "https://www.example.com"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "static"
  fill_value                     = 1.0
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 120
  expiration_duration            = 120
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "SELECT average(duration) FROM Transaction where appName = 'apm-NR'"
  }

  critical {
    operator              = "above"
    threshold             = 5.5
    threshold_duration    = 300
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = 3.5
    threshold_duration    = 600
    threshold_occurrences = "ALL"
  }
}

# resource "newrelic_workflow" "workflow-relicstaurant" {
#   name = "workflow-relicstaurant"
#   muting_rules_handling = "NOTIFY_ALL_ISSUES"

#   issues_filter {
#     name = "filter-name"
#     type = "FILTER"

#     predicate {
#       attribute = "accumulations.tag.team"
#       operator = "EXACTLY_MATCHES"
#       values = [ "growth" ]
#     }
#   }

#   destination {
#     channel_id = newrelic_notification_channel.some_channel.id
#   }
# }