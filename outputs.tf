output "autoscalingplans_scaling_plans_id" {
  description = "Map of id values across all autoscalingplans_scaling_plans, keyed the same as var.autoscalingplans_scaling_plans"
  value       = { for k, v in aws_autoscalingplans_scaling_plan.autoscalingplans_scaling_plans : k => v.id if v.id != null && length(v.id) > 0 }
}
output "autoscalingplans_scaling_plans_application_source" {
  description = "Map of application_source values across all autoscalingplans_scaling_plans, keyed the same as var.autoscalingplans_scaling_plans"
  value       = { for k, v in aws_autoscalingplans_scaling_plan.autoscalingplans_scaling_plans : k => one(v.application_source) if v.application_source != null && length(v.application_source) > 0 }
}
output "autoscalingplans_scaling_plans_name" {
  description = "Map of name values across all autoscalingplans_scaling_plans, keyed the same as var.autoscalingplans_scaling_plans"
  value       = { for k, v in aws_autoscalingplans_scaling_plan.autoscalingplans_scaling_plans : k => v.name if v.name != null && length(v.name) > 0 }
}
output "autoscalingplans_scaling_plans_region" {
  description = "Map of region values across all autoscalingplans_scaling_plans, keyed the same as var.autoscalingplans_scaling_plans"
  value       = { for k, v in aws_autoscalingplans_scaling_plan.autoscalingplans_scaling_plans : k => v.region if v.region != null && length(v.region) > 0 }
}
output "autoscalingplans_scaling_plans_scaling_instruction" {
  description = "Map of scaling_instruction values across all autoscalingplans_scaling_plans, keyed the same as var.autoscalingplans_scaling_plans"
  value       = { for k, v in aws_autoscalingplans_scaling_plan.autoscalingplans_scaling_plans : k => v.scaling_instruction if v.scaling_instruction != null && length(v.scaling_instruction) > 0 }
}
output "autoscalingplans_scaling_plans_scaling_plan_version" {
  description = "Map of scaling_plan_version values across all autoscalingplans_scaling_plans, keyed the same as var.autoscalingplans_scaling_plans"
  value       = { for k, v in aws_autoscalingplans_scaling_plan.autoscalingplans_scaling_plans : k => v.scaling_plan_version if v.scaling_plan_version != null }
}

