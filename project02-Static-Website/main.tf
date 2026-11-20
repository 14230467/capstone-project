provider "aws" {
 region = "ap-south-1"
}

resource "aws_s3_bucket" "website" {
 bucket = "my-terraform-static-website-2026-demo"
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
 bucket = aws_s3_bucket.website.id

 index_document {
   suffix = "index.html"
 }
}

# Allow public access
resource "aws_s3_bucket_public_access_block" "public" {
 bucket = aws_s3_bucket.website.id

 block_public_acls       = false
 block_public_policy     = false
 ignore_public_acls      = false
 restrict_public_buckets = false
}

# Bucket policy
resource "aws_s3_bucket_policy" "policy" {
 bucket = aws_s3_bucket.website.id

 depends_on = [aws_s3_bucket_public_access_block.public]

 policy = jsonencode({
   Version = "2012-10-17"
   Statement = [{
     Effect    = "Allow"
     Principal = "*"
     Action    = "s3:GetObject"
     Resource  = "${aws_s3_bucket.website.arn}/*"
   }]
 })
}

# Upload HTML
resource "aws_s3_object" "index" {
 bucket       = aws_s3_bucket.website.id
 key          = "index.html"
 source       = "index.html"
 content_type = "text/html"
}

# Website URL
output "website_url" {
 value = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}