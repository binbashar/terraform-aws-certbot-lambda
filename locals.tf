locals {
  tags = merge(var.tags, map("Application", "certbot-lambda"))
}