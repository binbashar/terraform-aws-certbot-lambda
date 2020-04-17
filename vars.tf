#
# Cloud Resources
#
variable "name_prefix" {
  description = "A prefix used for naming resources"
  default     = "certbot-lambda"
}

variable "name" {
  description = "A name for naming resources"
}

variable "hosted_zone_id" {
  description = "The id of the hosted zone that will be modified to prove ownership of the domain"
}

variable "function_trigger_schedule_expression" {
  description = "A cron-like expression that determines when the function is triggered"
  default     = "cron(0 */12 * * ? *)"
}

variable "tags" {
  description = "Resource Tags"
  default     = {}
}

#
# LetsEncrypt Certificate Settings
#
variable "contact_email" {
  description = "Contact email for LetsEncrypt notifications"
}

variable "certificate_domains" {
  description = "Domains that will be included in the certificate"
}