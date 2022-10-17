<a href="https://github.com/binbashar">
    <img src="https://raw.githubusercontent.com/binbashar/le-ref-architecture-doc/master/docs/assets/images/logos/binbash-leverage-banner.png" width="1032" align="left" alt="Binbash"/>
</a>
<br clear="left"/>

# Certbot Lambda

This module deploys an AWS Lambda function that generates Let's Encrypt certificates via *certbot*, for the given domains.
The Lambda is triggered by a CloudWatch event rule whose schedule can be set through the 'function_trigger_schedule_expression' variable.

### Considerations
The original pyhton source code was taken from https://github.com/kingsoftgames/certbot-lambda and
was adapted to the needs of the project at hand.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.28 |
| aws | ~> 2.70 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.70 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_domains | Domains that will be included in the certificate | `any` | n/a | yes |
| contact\_email | Contact email for LetsEncrypt notifications | `any` | n/a | yes |
| function\_trigger\_schedule\_expression | A cron-like expression that determines when the function is triggered | `string` | `"cron(0 */12 * * ? *)"` | no |
| hosted\_zone\_id | The id of the hosted zone that will be modified to prove ownership of the domain | `any` | n/a | yes |
| name | A name for naming resources | `any` | n/a | yes |
| name\_prefix | A prefix used for naming resources | `string` | `"certbot-lambda"` | no |
| tags | Resource Tags | `map` | `{}` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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

---

## Binbash Leverage | DevOps Automation Code Library Integration

In order to get the full automated potential of the
[Binbash Leverage DevOps Automation Code Library](https://leverage.binbash.com.ar/how-it-works/code-library/code-library/)  
you should initialize all the necessary helper **Makefiles**.

#### How?
You must execute the `make init-makefiles` command  at the root context

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - init-makefiles     initialize makefiles

```

### Why?
You'll get all the necessary commands to automatically operate this module via a dockerized approach,
example shown below

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - circleci-validate-config  ## Validate A CircleCI Config (https
 - format-check        ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - format              ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - tf-dir-chmod        ## run chown in ./.terraform to gran that the docker mounted dir has the right permissions
 - version             ## Show terraform version
 - init-makefiles      ## initialize makefiles
```

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make format-check
docker run --rm -v /home/delivery/Binbash/repos/Leverage/terraform/terraform-aws-backup-by-tags:"/go/src/project/":rw -v :/config -v /common.config:/common-config/common.config -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig -v ~/.aws/bb:/root/.aws/bb -e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/bb/credentials -e AWS_CONFIG_FILE=/root/.aws/bb/config --entrypoint=/bin/terraform -w "/go/src/project/" -it binbash/terraform-awscli-slim:0.12.28 fmt -check
```

# Release Management
### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-certbot-lambda/master/figures/circleci-logo.png"
   alt="circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-certbot-lambda) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-certbot-lambda/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-certbot-lambda/blob/master/CHANGELOG.md)
