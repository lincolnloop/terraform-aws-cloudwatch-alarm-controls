##########################################
#  Data configurations for the module    #
##########################################
data "aws_caller_identity" "current" {}

##########################################
#   CloudWatch resources                 #  
##########################################
resource "aws_cloudwatch_log_metric_filter" "cloudwatch" {
  for_each       = var.alarms
  log_group_name = var.log_group_name
  name           = each.key
  pattern        = each.value.pattern
  metric_transformation {
    name      = each.key
    namespace = "LogMetrics"
    value     = 1
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch" {
  for_each            = var.alarms
  alarm_name          = each.key
  alarm_description   = each.value.description
  period              = 3600
  statistic           = "Maximum"
  namespace           = "LogMetrics"
  metric_name         = each.key
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = lookup(each.value, "threshold", 0)
  alarm_actions       = var.alarm_action_arns
  tags                = var.tags
}