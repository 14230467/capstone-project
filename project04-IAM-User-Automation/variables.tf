variable "bucket_name" {
  description = "Existing S3 bucket name"
  type        = string
  default     = "my-demo-bucket-2026"
}
variable "s3_read_actions" {
  description = "Allowed S3 read-only actions"
  type        = list(string)

  default = [
    "s3:GetObject",
    "s3:ListBucket"
  ]
}