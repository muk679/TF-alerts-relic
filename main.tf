

// Create a policy to track
resource "newrelic_alert_policy" "policy-all" {
   for_each = var.policies 
   name=each.value
  incident_preference = "PER_POLICY"

}


  
resource "newrelic_nrql_alert_condition" "condition-relicstaurants-of-apm" {
  for_each = var.alertsapm 
  account_id                     = var.accid
  policy_id                      = newrelic_alert_policy.policy-all[each.value.policy_key].id

  type                           = each.value.type
  name                           = each.value.name
  description                    = each.value.description
  enabled                        = each.value.enabled
  violation_time_limit_seconds   = each.value.violation_time_limit_seconds
  fill_option                    = each.value.fill_option
  fill_value                     = each.value.fill_value
  aggregation_window             = each.value.aggregation_window
  aggregation_method             = each.value.aggregation_method
  aggregation_delay              = each.value.aggregation_delay
  expiration_duration            = each.value.expiration_duration
  open_violation_on_expiration   = each.value.open_violation_on_expiration
  close_violations_on_expiration = each.value.close_violations_on_expiration
  slide_by                       = each.value.slide_by

  nrql {
    query = each.value.nrql 
  }

  critical {
    operator              = "above"
    threshold             = each.value.critical_threshold
    threshold_duration    = each.value.critical_threshold_duration
    threshold_occurrences = "ALL"
  }

  dynamic "warning" {
    for_each = each.value.warning ? [each.value] : []
    content {
        operator       = "above"
    threshold             = each.value.warning_threshold
    threshold_duration    = each.value.warning_threshold_duration
    threshold_occurrences = "ALL"
  }
   }
}



resource "newrelic_nrql_alert_condition" "condition-relicstaurants-of-infra" {
  for_each                       = var.alertsinfra  
  account_id                     = var.accid 
  policy_id                      = newrelic_alert_policy.policy-all[each.value.policy_key].id

  type                           = each.value.type
  name                           = each.value.name
  description                    = each.value.description
  enabled                        = each.value.enabled
  violation_time_limit_seconds   = each.value.violation_time_limit_seconds
  fill_option                    = each.value.fill_option
  fill_value                     = each.value.fill_value
  aggregation_window             = each.value.aggregation_window
  aggregation_method             = each.value.aggregation_method
  aggregation_delay              = each.value.aggregation_delay
  expiration_duration            = each.value.expiration_duration
  open_violation_on_expiration   = each.value.open_violation_on_expiration
  close_violations_on_expiration = each.value.close_violations_on_expiration
  slide_by                       = each.value.slide_by

  nrql {
    query = each.value.nrql 
  }

  critical {
    operator              = "above"
    threshold             = each.value.critical_threshold
    threshold_duration    = each.value.critical_threshold_duration
    threshold_occurrences = "ALL"
  }

  dynamic "warning" {
    for_each = each.value.warning ? [each.value] : []
    content {
        operator       = "above"
    threshold             = each.value.warning_threshold
    threshold_duration    = each.value.warning_threshold_duration
    threshold_occurrences = "ALL"
  }
   }
}










# resource "newrelic_alert_policy" "policy-relicstaurant-infraa" {
#   name = "policy-relicstaurant-infraa"
# }






# // Create a reusable notification destination
resource "newrelic_notification_destination" "email-destt" {
  account_id = var.accid
  name = "mukheja679@gmail.com"
  type = "EMAIL"

  property {
    key = "email"
    value = "mukheja679@gmail.com"
  }
}

# // Create a notification channel to use in the workflow
resource "newrelic_notification_channel" "email-channel" {
  name = "channel-email"
  type = "EMAIL"
  destination_id = newrelic_notification_destination.email-destt.id
  product = "IINT" // Please note the product used!

  property {
    key = "payload"
    value = "{}"
    label = "Payload Template"
  }
}



# // A workflow that matches issues that include incidents triggered by the policy
resource "newrelic_workflow" "workflow-example" {
  name = "workflow-example"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "Filter-name"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator = "EXACTLY_MATCHES"
      values = [ for x in newrelic_alert_policy.policy-all : x.id]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.email-channel.id
  }
}

