
data "archive_file" "python_zip" {
  type        = "zip"
  source_file = "${path.module}/script/handler.py"
  output_path = "${path.module}/script/handler.zip"
}


resource "aws_lambda_function" "main_lambda" {
  function_name    = "${var.prefix}_auto_tags_lambda"
  handler          = "handler.lambda_handler"
  runtime          = "python3.8"
  timeout          = 10
  memory_size      = 128
  role             = aws_iam_role.iam_for_lambda.arn
  filename         = "${path.module}/script/handler.zip"
  source_code_hash = filebase64sha256("${path.module}/script/handler.zip")
  environment {
    variables = {
      TAGS_TO_APPLY = jsonencode(var.tags_to_apply)
    }
  }
}
