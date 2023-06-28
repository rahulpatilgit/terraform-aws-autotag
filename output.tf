output "lambda" {
  value = aws_lambda_function.main_lambda
}

output "iam_role" {
  value = aws_iam_role.iam_for_lambda
}