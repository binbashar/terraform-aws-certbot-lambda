#
# Lambda function that takes care of requesting the creation and renewal of
# LetsEncrypt certificates and stores them in an S3 bucket.
#
module "certbot_lambda_jenkins" {
  source = "github.com/binbashar/terraform-aws-lambda?ref=v1.2.0"

  function_name = "${var.name_prefix}-${var.name}"
  description   = "CertBot Lambda that creates and renews certificates for ${var.certificate_domains}"
  handler       = "main.lambda_handler"
  runtime       = "python3.6"
  timeout       = 300

  source_path = "${path.module}/src/"

  trusted_entities = ["events.amazonaws.com"]

  policy = {
    json = data.aws_iam_policy_document.bucket_permissions.json
  }

  environment = {
    variables = {
      EMAIL     = var.contact_email
      DOMAINS   = var.certificate_domains
      S3_BUCKET = aws_s3_bucket.certificates_store.id
      S3_PREFIX = var.name
    }
  }
}

#
# Lambda permissions on the bucket used to store certificates.
#
data "aws_iam_policy_document" "bucket_permissions" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.certificates_store.arn
    ]
  }

  statement {
    actions = [
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.certificates_store.arn,
      "${aws_s3_bucket.certificates_store.arn}/*"
    ]
  }

  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:GetChange"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
    ]
  }
}
