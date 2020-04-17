#
# This bucket will be used for storing certificates.
#
resource "aws_s3_bucket" "certificates_store" {
  bucket = "${var.name_prefix}-certificates-${var.name}"
  acl    = "private"
  force_destroy = true
  
  versioning {
    enabled = true
  }
  
  lifecycle {
    prevent_destroy = false
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  
  tags = local.tags
}