# AWS EC2 poweruser

This module will create a role, assumeable by another account, which has EC2 Poweruser priviledges.

## Example

```hcl
module "ec2-poweruser" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-ec2-poweruser?ref=v0.14.0"

  # The name of the role to create in this account.
  role_name = "..."

  # The ID of the other AWS account which can assume this role.
  source_account_id = "..."
}

```


<!-- START -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_path | n/a | `string` | `"/"` | no |
| role\_name | n/a | `string` | n/a | yes |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | `string` | `""` | no |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| role\_name | n/a |

<!-- END -->
