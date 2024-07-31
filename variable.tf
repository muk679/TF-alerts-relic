variable "policies" {
  type = map(string)
}

# variable "policy-name" {
#   type = string
# }


variable "alertsapm" {


  type = map(object({
    type                           = string
    policy_key                     = string
    name                           = string
    nrql                           = string
    critical_threshold             = number
    warning_threshold              = number
    critical_threshold_duration    = number
    warning_threshold_duration     = number
    warning                        = bool
    enabled                        = bool
    violation_time_limit_seconds   = number
    fill_option                    = string
    fill_value                     = number
    aggregation_window             = number
    aggregation_method             = string
    aggregation_delay              = number
    expiration_duration            = number
    open_violation_on_expiration   = bool
    close_violations_on_expiration = bool
    slide_by                       = number
    description                    = string
  }))
}

variable "accid" {
  type = number
}

variable "alertsinfra" {
  type = map(object({
 
    type                           = string
    policy_key                     = string
    name                           = string
    nrql                           = string
    critical_threshold             = number
    warning_threshold              = number
    critical_threshold_duration    = number
    warning_threshold_duration     = number
    warning                        = bool
    enabled                        = bool
    violation_time_limit_seconds   = number
    fill_option                    = string
    fill_value                     = number
    aggregation_window             = number
    aggregation_method             = string
    aggregation_delay              = number
    expiration_duration            = number
    open_violation_on_expiration   = bool
    close_violations_on_expiration = bool
    slide_by                       = number
    description                    = string

  }))
}
