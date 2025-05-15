#S3 Create
resource "aws_s3_bucket" "s3-terra" {
    bucket = "hello-s3-terraform"
    tags = {
        Name = "S3 Terraform"
    }
}


#ACL Ownership
resource "aws_s3_bucket_ownership_controls" "s3-own" {
  bucket = aws_s3_bucket.s3-terra.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-public-access" {
    bucket = aws_s3_bucket.s3-terra.id
    
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

#ACL Public
resource "aws_s3_bucket_acl" "s3-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3-own,
    aws_s3_bucket_public_access_block.s3-public-access,
  ]

  bucket = aws_s3_bucket.s3-terra.id
  acl    = "public-read-write"
}


#Bucket Policy
resource "aws_s3_bucket_policy" "s3-policy" {
  bucket = aws_s3_bucket.s3-terra.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Sid       =  "PublicReadGetObject"
            Effect    =  "Allow"
            Principal = "*"
            Action    = "s3:GetObject"
            Resource  = "${aws_s3_bucket.s3-terra.arn}/*"
        }
    ]
  })
}


#Lifecycle
resource "aws_s3_bucket_lifecycle_configuration" "s3-lifecycle" {
  bucket = aws_s3_bucket.s3-terra.id
  rule {
    id = "s3-lifecycle-terra"
    status = "Enabled"

    filter {
  prefix = "" #Teruntuk all object
} 

    transition {
      days          = 180
      storage_class = "DEEP_ARCHIVE"
    }

    #Standard                    = STANDARD
    #Intelligent-Tiering         = INTELLIGENT_TIERING
    #Standard-IA                 = STANDARD_IA
    #One Zone-IA                 = ONEZONE_IA
    #Glacier Instant Retrieval   = GLACIER_IR
    #Glacier Flexible Retrieval  = GLACIER
    #Glacier Deep Archive        = DEEP_ARCHIVE

    expiration {
      days = 365
    }
  }
}

#Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3-terra.id
  versioning_configuration {
    status = "Enabled"
  }
}