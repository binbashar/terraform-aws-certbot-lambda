# Create a timer that runs every 12 hours
resource "aws_cloudwatch_event_rule" "certbot_lambda_timer" {
  name                = "${var.name_prefix}-timer-${var.name}"
  schedule_expression = "cron(0 */12 * * ? *)"
}

# Specify the lambda function to run
resource "aws_cloudwatch_event_target" "lets_encrypt_timer_target" {
  rule = aws_cloudwatch_event_rule.certbot_lambda_timer.name
  arn  = module.certbot_lambda_jenkins.function_arn
}

# Give cloudwatch permission to invoke the function
resource "aws_lambda_permission" "permission" {
  action        = "lambda:InvokeFunction"
  function_name = module.certbot_lambda_jenkins.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.certbot_lambda_timer.arn
}