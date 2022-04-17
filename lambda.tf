resource "aws_lambda_function" "lambda_ses" {
  function_name = "ses_lambda_1"
  filename = "lambda_email_function.zip"
  handler = "lambda_email_function.lambda_handler"
  runtime       = "python3.8"
  role = aws_iam_role.iam_for_lambda.arn
  # ... other configuration ...
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
  ]
}
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_1"

  assume_role_policy =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
        }
    ]
}
EOF
}   
# resource "aws_lambda_permission" "allow_bucket" {
#   statement_id  = "AllowExecutionFromS3Bucket"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.lambda_ses.arn
#   principal     = "s3.amazonaws.com"
# }

# resource "aws_s3_bucket_notification" "bucket_notification" {
#   bucket = "yasser-backend-bucket"

#   lambda_function {
#     lambda_function_arn = aws_lambda_function.lambda_ses.arn
#     events              = ["s3:ObjectCreated:*"]
#     filter_prefix       = "AWSLogs/"
#     filter_suffix       = ".log"
#   }

#   depends_on = [aws_lambda_permission.allow_bucket]
# }
# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_email_logging" {
  name        = "lambda_email_logging_1"
  path        = "/"
  description = "IAM policy for logging emails to ses from a lambda"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ses:SendEmail",
                "ses:SendRawEmail"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_email_logging.arn
}