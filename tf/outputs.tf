output "bucket_name" {
  value = aws_s3_bucket.emr_bucket.bucket
}

output "emr_cluster_id" {
  value = aws_emr_cluster.emr_cluster.id
}
