
#  policy-name = "infra-policy"
accid = "4510907"

policies = {
  policy-1 = "policy-relicstaurant-apm"
  policy-2 = "policy-infra-relic"
}

alertsapm = {
  throughput-alert-apm = {

    type                           = "static"
    policy_key                     = "policy-1"
    name                           = "throughput-alert-apm"
    nrql                           = "SELECT rate(count(apm.service.transaction.duration), 1 minute) as 'Web throughput' FROM Metric WHERE (entity.guid = 'NDUxMDkwN3xBUE18QVBQTElDQVRJT058NTQyMzQ2NzM1') AND (transactionType = 'Web')"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = false
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
    description                    = "Alert when transactions are taking too long"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }

  web-transaction-time-alert-apm = {

    type                           = "static"
    policy_key                     = "policy-1"
    name                           = "web-transaction-time-alert-apm"
    nrql                           = "SELECT sum(apm.service.overview.web * 1000) FROM Metric WHERE (entity.guid = 'NDUxMDkwN3xBUE18QVBQTElDQVRJT058NTQyMzQ2NzM1') FACET `segmentName`"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = false
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 120
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for web transaction time"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }

  apdex-alert-apm = {

    type                           = "static"
    policy_key                     = "policy-1"
    name                           = "apdex-alert-apm"
    nrql                           = "SELECT apdex(apm.service.apdex) as 'App server' FROM Metric WHERE (entity.guid = 'NDUxMDkwN3xBUE18QVBQTElDQVRJT058NTQyMzQ2NzM1')"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = true
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 120
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for apdex score"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }

  apdex-alert-apm-EU = {

    type                           = "static"
    policy_key                     = "policy-1"
    name                           = "apdex-alert-apm-EU"
    nrql                           = "SELECT apdex(apm.service.apdex.user) as 'End user' FROM Metric WHERE (entity.guid = 'NDUxMDkwN3xBUE18QVBQTElDQVRJT058NTQyMzQ2NzM1')"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = true
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 120
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for apdex score in EU"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }

  Error-rate-apm = {

    type                           = "static"
    policy_key                     = "policy-1"
    name                           = "Error-rate-apm"
    nrql                           = "SELECT sum(apm.service.error.count['count']) / count(apm.service.transaction.duration) AS 'Web errors' FROM Metric WHERE (entity.guid = 'NDUxMDkwN3xBUE18QVBQTElDQVRJT058NTQyMzQ2NzM1')"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = true
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 1
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for error rate"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }


}


alertsinfra = {
  cpu-utilization-infra = {
    type                           = "static"
    policy_key                     = "policy-2"
    name                           = "cpu_utilization"
    nrql                           = "SELECT average(cpuPercent)  FROM SystemSample WHERE hostname = 'CEQ-ICT-LAPTOP-287' "
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = false
    type                           = "static"
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 1
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for cpu utilization"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120

  }

  disk-utilization-infra = {
    type                           = "static"
    policy_key                     = "policy-2"
    name                           = "disk_utilization"
    nrql                           = "SELECT latest(diskUsedPercent) AS `Used %` FROM StorageSample WHERE (entityGuid = 'NDUxMDkwN3xJTkZSQXxOQXw4Mzk0OTQ0NDQxNjE1NjEzNzA4')"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = false
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 1
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for disk uitlization"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }

  memory-utilization-infra = {
    type                           = "static"
    policy_key                     = "policy-2"
    name                           = "memory_utilization"
    nrql                           = "SELECT average(memoryUsedPercent) AS `Memory used %` FROM SystemSample WHERE (entityGuid = 'NDUxMDkwN3xJTkZSQXxOQXw4Mzk0OTQ0NDQxNjE1NjEzNzA4')"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = true
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 1
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for memory utilization"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }

  storage-utilization-infra = {
    type                           = "static"
    policy_key                     = "policy-2"
    name                           = "storage_utilization"
    nrql                           = "SELECT average(diskUsedPercent) AS `Storage used %` FROM StorageSample WHERE (entityGuid = 'NDUxMDkwN3xJTkZSQXxOQXw4Mzk0OTQ0NDQxNjE1NjEzNzA4')"
    critical_threshold             = 1
    warning_threshold              = 0.5
    warning                        = true
    enabled                        = true
    violation_time_limit_seconds   = 3600
    fill_option                    = "static"
    fill_value                     = 1.0
    aggregation_window             = 60
    aggregation_method             = "event_flow"
    aggregation_delay              = 1
    expiration_duration            = 120
    open_violation_on_expiration   = false
    close_violations_on_expiration = false
    slide_by                       = 30
    description                    = "Alert for storage uitlization"
    critical_threshold_duration    = 60
    warning_threshold_duration     = 120
  }

}
