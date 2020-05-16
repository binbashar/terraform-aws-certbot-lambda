<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-certbot-lambda/master/figures/binbash-logo.png" alt="binbash" width="250"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-certbot-lambda/master/figures/binbash-leverage-terraform-logo.png"
  alt="leverage" width="130"/>
</div>

# Certbot Lambda

This module deploys an AWS Lambda function that generates Let's Encrypt certificates via *certbot*, for the given domains.
The Lambda is triggered by a CloudWatch event rule whose schedule can be set through the 'function_trigger_schedule_expression' variable.

### Considerations
The original pyhton source code was taken from https://github.com/kingsoftgames/certbot-lambda and
was adapted to the needs of the project at hand.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| certificate\_domains | Domains that will be included in the certificate | string | n/a | yes |
| contact\_email | Contact email for LetsEncrypt notifications | string | n/a | yes |
| hosted\_zone\_id | The id of the hosted zone that will be modified to prove ownership of the domain | string | n/a | yes |
| name | A name for naming resources | string | n/a | yes |
| function\_trigger\_schedule\_expression | A cron-like expression that determines when the function is triggered | string | `"cron(0 */12 * * ? *)"` | no |
| name\_prefix | A prefix used for naming resources | string | `"certbot-lambda"` | no |
| tags | Resource Tags | map | `{}` | no |

## Examples
The following example will deploy a Lambda that will generate certificates for *test.example.com*:
```
module "certbot_lambda_test" {
  source                                = "../../"

  # This is used for naming resources
  name                                  = "test"

  # This email used by Let's Encrypt for sending notifications about certificates
  contact_email                         = "admin@example.com"

  # This is the domain for the certificate
  certificate_domains                   = "test.example.com"

  # This zone will be automatically updated to meet the DNS challenge required by Let's Encrypt
  hosted_zone_id                        = aws_route53_record.example_com.zone_id

  # This is a cron-like expressions that determines when the Lambda is triggered
  function_trigger_schedule_expression  = "cron(12 20 * * ? *)"
}
```

## TODO
- Add examples and tests (terratests)

# Release Management
### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-certbot-lambda/master/figures/circleci-logo.png" alt="circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-certbot-lambda) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-certbot-lambda/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-certbot-lambda/blob/master/CHANGELOG.md)
