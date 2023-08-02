# Terraform AWS CloudWatch Alerts

This module creates CloudWatch alerts.
## Usage

```hcl
module "cloudwatch_alarms" {
  source                       = "github.com/lincolnloop/terraform-aws-cloudwatch-alarm-controls"
  alarms                       = var.alarms
  tags                         = var.tags
  log_group_name               = "/cloudtrail"
  alarm_action_arns            = [arn::..] 
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm_action_arns | List of ARNs for the alarm actions (e.g., SNS topic ARNs) | `list(string)` | no | yes |
| tags | Configuration for resources tags. | `object` | Review next section for default value | yes |
| alarms | Configuration for CloudWatch alarms. | `object` | Review next section for default value | yes |
| log_group_name | Name for the CloudWatch log group to use as input for the alarms. | `string` | no | yes |

### Variable `tags`

This input variable controls the tags that will be added to all the resources.
```
  tags = {
    Application = "cloudwatch-alarms"
  }
```

Default value is shown here

### Variable `alarms`

This input variable controls the Cloudwatch alarm configuration.

Default value is shown here
```
  alarms = {
    "CIS-3.1-UnauthorizedAPICalls" = {
      description = "3.1 - Ensure a log metric filter and alarm exist for unauthorized API calls "
      pattern     = "{($.errorCode=\"*UnauthorizedOperation\") || ($.errorCode=\"AccessDenied*\")}"
      threshold   = 5
    }
    "CIS-3.2-ConsoleSigninWithoutMFA" = {
      description = "3.2 - Ensure a log metric filter and alarm exist for AWS Management Console sign-in without MFA "
      pattern     = "{($.eventName=\"ConsoleLogin\") && ($.additionalEventData.MFAUsed !=\"Yes\")}"
    }
    "CIS-3.3-RootAccountUsage" = {
      description = "3.3 - Ensure a log metric filter and alarm exist for usage of \"root\" account"
      pattern     = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
    }
    "CIS-3.4-IAMPolicyChanges" = {
      description = "3.4 - Ensure a log metric filter and alarm exist for IAM policy changes"
      pattern     = "{($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy)}"
    }
    "CIS-3.5-CloudTrailChanges" = {
      description = "3.5 - Ensure a log metric filter and alarm exist for CloudTrail configuration changes"
      pattern     = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
    }
    "CIS-3.6-ConsoleAuthenticationFailure" = {
      description = "3.6 - Ensure a log metric filter and alarm exist for AWS Management Console authentication failures"
      pattern     = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
      threshold   = 5
    }
    "CIS-3.7-DisableOrDeleteCMK" = {
      description = "3.7 - Ensure a log metric filter and alarm exist for disabling or scheduled deletion of customer created CMKs"
      pattern     = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
    }
    "CIS-3.8-S3BucketPolicyChanges" = {
      description = "3.8 - Ensure a log metric filter and alarm exist for S3 bucket policy changes"
      pattern     = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
    }
    "CIS-3.9-AWSConfigChanges" = {
      description = "3.9 - Ensure a log metric filter and alarm exist for AWS Config configuration changes"
      pattern     = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
    }
    "CIS-3.10-SecurityGroupChanges" = {
      description = "3.10 - Ensure a log metric filter and alarm exist for security group changes"
      pattern     = "{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}"
    }
    "CIS-3.11-NetworkACLChanges" = {
      description = "3.11 - Ensure a log metric filter and alarm exist for changes to Network Access Control Lists (NACL)"
      pattern     = "{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}"
    }
    "CIS-3.12-NetworkGatewayChanges" = {
      description = "3.12 - Ensure a log metric filter and alarm exist for changes to network gateways"
      pattern     = "{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}"
    }
    "CIS-3.13-RouteTableChanges" = {
      description = "3.13 - Ensure a log metric filter and alarm exist for route table changes"
      pattern     = "{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}"
    }
    "CIS-3.14-VPCChanges" = {
      description = "3.14 – Ensure a log metric filter and alarm exist for VPC changes"
      pattern     = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
    }
  }
```
## Requirements

- Terraform 1.4 or newer
- AWS Provider 4.67 or newer