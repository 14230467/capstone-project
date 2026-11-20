provider "aws" {
 region = "ap-south-1"
}

# Create IAM User
resource "aws_iam_user" "user" {
 name = "terraform-s3-reader-14230467"
}

# Create IAM Policy
resource "aws_iam_policy" "s3_read" {
 name        = "S3ReadOnlyPolicy"
 description = "Allow read-only access to a specific S3 bucket"

 policy = jsonencode({
   Version = "2012-10-17"

   Statement = [
     {
       Effect = "Allow"
       Action = var.s3_read_actions

       Resource = [
         "arn:aws:s3:::${var.bucket_name}",
         "arn:aws:s3:::${var.bucket_name}/*"
       ]
     }
   ]
 })
}

# Attach Policy to User
resource "aws_iam_user_policy_attachment" "attach" {
 user       = aws_iam_user.user.name
 policy_arn = aws_iam_policy.s3_read.arn
}

output "iam_username" {
 value = aws_iam_user.user.name
}

output "policy_arn" {
 value = aws_iam_policy.s3_read.arn
}