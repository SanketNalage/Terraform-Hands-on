resource "aws_s3_bucket" "mybucket" {
  for_each = {
    dev  = "dapp-bucket-${random_id.suffix.hex}"
    qa   = "qapp-bucket-${random_id.suffix.hex}"
    stag = "sapp-bucket-${random_id.suffix.hex}"
    prod = "papp-bucket-${random_id.suffix.hex}"
  }

  bucket = "${each.key}-${each.value}"

  # Modern S3 settings
  tags = {
    Environment = each.key
    BucketName  = "${each.key}-${each.value}"
    ManagedBy   = "Terraform"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

# Enable versioning for all buckets
resource "aws_s3_bucket_versioning" "versioning" {
  for_each = aws_s3_bucket.mybucket

  bucket = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access for all buckets
resource "aws_s3_bucket_public_access_block" "block_public" {
  for_each = aws_s3_bucket.mybucket

  bucket = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}