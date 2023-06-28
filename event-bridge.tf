resource "aws_cloudwatch_event_rule" "instance_launch_rule" {
  name        = "${var.prefix}_auto_tags_event"
  description = "Trigger Lambda on EC2 instance launch"

  event_pattern = <<EOF
{
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Instance State-change Notification"
  ],
  "detail": {
    "state": [
      "running"
    ]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "instance_launch_target" {
  rule      = aws_cloudwatch_event_rule.instance_launch_rule.name
  target_id = "lambda-target"
  arn       = aws_lambda_function.main_lambda.arn
}