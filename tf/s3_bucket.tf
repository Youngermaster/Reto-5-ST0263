resource "aws_s3_bucket" "emr_bucket" {
  bucket = "your-unique-bucket-name-lab-emr"  # Cambia a un nombre único
  acl    = "private"

  tags = {
    Name = "EMR Bucket"
  }
}

resource "aws_s3_bucket_object" "data_folder" {
  bucket = aws_s3_bucket.emr_bucket.bucket
  key    = "data/"
}

resource "aws_s3_bucket_object" "logs_folder" {
  bucket = aws_s3_bucket.emr_bucket.bucket
  key    = "logs/"
}
