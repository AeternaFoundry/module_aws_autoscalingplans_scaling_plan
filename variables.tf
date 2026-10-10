variable "autoscalingplans_scaling_plans" {
  description = <<EOT
Map of autoscalingplans_scaling_plans, attributes below
Required:
    - name
    - application_source (block):
        - cloudformation_stack_arn (optional)
        - tag_filter (optional, block):
            - key (required)
            - values (optional)
    - scaling_instruction (block):
        - customized_load_metric_specification (optional, block):
            - dimensions (optional)
            - metric_name (required)
            - namespace (required)
            - statistic (required)
            - unit (optional)
        - disable_dynamic_scaling (optional)
        - max_capacity (required)
        - min_capacity (required)
        - predefined_load_metric_specification (optional, block):
            - predefined_load_metric_type (required)
            - resource_label (optional)
        - predictive_scaling_max_capacity_behavior (optional)
        - predictive_scaling_max_capacity_buffer (optional)
        - predictive_scaling_mode (optional)
        - resource_id (required)
        - scalable_dimension (required)
        - scaling_policy_update_behavior (optional)
        - scheduled_action_buffer_time (optional)
        - service_namespace (required)
        - target_tracking_configuration (required, block):
            - customized_scaling_metric_specification (optional, block):
                - dimensions (optional)
                - metric_name (required)
                - namespace (required)
                - statistic (required)
                - unit (optional)
            - disable_scale_in (optional)
            - estimated_instance_warmup (optional)
            - predefined_scaling_metric_specification (optional, block):
                - predefined_scaling_metric_type (required)
                - resource_label (optional)
            - scale_in_cooldown (optional)
            - scale_out_cooldown (optional)
            - target_value (required)
Optional:
    - region
EOT

  type = map(object({
    name   = string
    region = optional(string)
    application_source = object({
      cloudformation_stack_arn = optional(string)
      tag_filter = optional(list(object({
        key    = string
        values = optional(set(string))
      })))
    })
    scaling_instruction = list(object({
      customized_load_metric_specification = optional(object({
        dimensions  = optional(map(string))
        metric_name = string
        namespace   = string
        statistic   = string
        unit        = optional(string)
      }))
      disable_dynamic_scaling = optional(bool)
      max_capacity            = number
      min_capacity            = number
      predefined_load_metric_specification = optional(object({
        predefined_load_metric_type = string
        resource_label              = optional(string)
      }))
      predictive_scaling_max_capacity_behavior = optional(string)
      predictive_scaling_max_capacity_buffer   = optional(number)
      predictive_scaling_mode                  = optional(string)
      resource_id                              = string
      scalable_dimension                       = string
      scaling_policy_update_behavior           = optional(string)
      scheduled_action_buffer_time             = optional(number)
      service_namespace                        = string
      target_tracking_configuration = list(object({
        customized_scaling_metric_specification = optional(object({
          dimensions  = optional(map(string))
          metric_name = string
          namespace   = string
          statistic   = string
          unit        = optional(string)
        }))
        disable_scale_in          = optional(bool)
        estimated_instance_warmup = optional(number)
        predefined_scaling_metric_specification = optional(object({
          predefined_scaling_metric_type = string
          resource_label                 = optional(string)
        }))
        scale_in_cooldown  = optional(number)
        scale_out_cooldown = optional(number)
        target_value       = number
      }))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        v.application_source.tag_filter == null || (length(v.application_source.tag_filter) <= 50)
      )
    ])
    error_message = "Each tag_filter list must contain at most 50 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        length(v.scaling_instruction) >= 1
      )
    ])
    error_message = "Each scaling_instruction list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        alltrue([for item in v.scaling_instruction : (length(item.target_tracking_configuration) >= 1 && length(item.target_tracking_configuration) <= 10)])
      )
    ])
    error_message = "Each target_tracking_configuration list must contain between 1 and 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        alltrue([for item in v.scaling_instruction : (item.predefined_load_metric_specification == null || (item.predefined_load_metric_specification.resource_label == null || (length(item.predefined_load_metric_specification.resource_label) >= 1 && length(item.predefined_load_metric_specification.resource_label) <= 1023)))])
      )
    ])
    error_message = "must be between 1 and 1023 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        alltrue([for item in v.scaling_instruction : (item.predictive_scaling_max_capacity_buffer == null || (item.predictive_scaling_max_capacity_buffer >= 1 && item.predictive_scaling_max_capacity_buffer <= 100))])
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        alltrue([for item in v.scaling_instruction : (item.scheduled_action_buffer_time == null || (item.scheduled_action_buffer_time >= 0))])
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        alltrue([for item in v.scaling_instruction : (alltrue([for item in item.target_tracking_configuration : (item.predefined_scaling_metric_specification == null || (item.predefined_scaling_metric_specification.resource_label == null || (length(item.predefined_scaling_metric_specification.resource_label) >= 1 && length(item.predefined_scaling_metric_specification.resource_label) <= 1023)))]))])
      )
    ])
    error_message = "must be between 1 and 1023 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.autoscalingplans_scaling_plans : (
        alltrue([for item in v.scaling_instruction : (alltrue([for item in item.target_tracking_configuration : (item.target_value >= 8.515920e-109 && item.target_value <= 1.174271e+108)]))])
      )
    ])
    error_message = "must be between 8.515920e-109 and 1.174271e+108"
  }
  # Note: 12 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

