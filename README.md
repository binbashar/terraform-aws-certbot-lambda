# Certbot Lambda

This module deploys an AWS Lambda function that generates Let's Encrypt certificates via *certbot*, for the given domains. The Lambda is triggered by a CloudWatch event rule whose schedule can be set through the 'function_trigger_schedule_expression' variable.

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