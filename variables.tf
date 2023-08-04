variable "alarm_action_arns" {
  description = "List of ARNs for the alarm actions (e.g., SNS topic ARNs)"
  type        = list(string)
}

variable "tags" {
  description = "Tags configuration for Cloudwatch"
  type        = map(string)
  default = {
    Application = "cloudwatch-alarms"
  }
}

variable "alarms" {
  description = "Alarms configuration for CloudWatch"
  type = map(object({
    description = string
    pattern     = string
    threshold   = optional(number)
  }))
  default = {
    "Cloudwatch.1-RootAccountUsage" = {
      description = "Cloudwatch.1 - Ensure a log metric filter and alarm exist for usage of \"root\" account"
      pattern     = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
    }
    "Cloudwatch.2-UnauthorizedAPICalls" = {
      description = "Cloudwatch.2 - Ensure a log metric filter and alarm exist for unauthorized API calls "
      pattern     = "{($.errorCode=\"*UnauthorizedOperation\") || ($.errorCode=\"AccessDenied*\")}"
      threshold   = 5
    }
    "Cloudwatch.3-ConsoleSigninWithoutMFA" = {
      description = "Cloudwatch.3 - Ensure a log metric filter and alarm exist for AWS Management Console sign-in without MFA "
      pattern     = "{($.eventName=\"ConsoleLogin\") && ($.additionalEventData.MFAUsed !=\"Yes\") && && ($.userIdentity.type = \"IAMUser\") && ($.responseElements.ConsoleLogin = \"Success\")}"
    }
    "CloudWatch.4-IAMPolicyChanges" = {
      description = "Cloudwatch.4 - Ensure a log metric filter and alarm exist for IAM policy changes"
      pattern     = "{($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy)}"
    }
    "CloudWatch.5-CloudTrailChanges" = {
      description = "Cloudwatch.5 - Ensure a log metric filter and alarm exist for CloudTrail configuration changes"
      pattern     = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
    }
    "CloudWatch.6-ConsoleAuthenticationFailure" = {
      description = "Cloudwatch.6 - Ensure a log metric filter and alarm exist for AWS Management Console authentication failures"
      pattern     = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
      threshold   = 5
    }
    "CloudWatch.7-DisableOrDeleteCMK" = {
      description = "Cloudwatch.7 - Ensure a log metric filter and alarm exist for disabling or scheduled deletion of customer created CMKs"
      pattern     = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
    }
    "CloudWatch.8-S3BucketPolicyChanges" = {
      description = "Cloudwatch.8 - Ensure a log metric filter and alarm exist for S3 bucket policy changes"
      pattern     = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
    }
    "CloudWatch.9-AWSConfigChanges" = {
      description = "Cloudwatch.9 - Ensure a log metric filter and alarm exist for AWS Config configuration changes"
      pattern     = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
    }
    "CloudWatch.10-SecurityGroupChanges" = {
      description = "Cloudwatch.10 - Ensure a log metric filter and alarm exist for security group changes"
      pattern     = "{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}"
    }
    "CloudWatch.11-NetworkACLChanges" = {
      description = "Cloudwatch.11 - Ensure a log metric filter and alarm exist for changes to Network Access Control Lists (NACL)"
      pattern     = "{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}"
    }
    "CloudWatch.12-NetworkGatewayChanges" = {
      description = "Cloudwatch.12 - Ensure a log metric filter and alarm exist for changes to network gateways"
      pattern     = "{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}"
    }
    "CloudWatch.13-RouteTableChanges" = {
      description = "Cloudwatch.13 - Ensure a log metric filter and alarm exist for route table changes"
      pattern     = "{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}"
    }
    "CloudWatch.14-VPCChanges" = {
      description = "Cloudwatch.14 – Ensure a log metric filter and alarm exist for VPC changes"
      pattern     = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
    }
  }
}
variable "log_group_name" {
  type = string
  description = "Name for the CloudWatch log group to use as input"
}
