resource "aws_emr_cluster" "emr_cluster" {
  name          = "emr-MyClusterEMR"
  release_label = "emr-6.14.0"
  applications  = ["Hadoop", "Hive", "Spark", "Hue", "Sqoop", "Zeppelin", "Livy"]

  ec2_attributes {
    key_name = aws_key_pair.emr_key.key_name
    subnet_id = "your-subnet-id"  # Cambia al ID de tu subred
    emr_managed_master_security_group = aws_security_group.emr_sg.id
    emr_managed_slave_security_group  = aws_security_group.emr_sg.id
  }

  master_instance_group {
    instance_type = "m4.large"
    instance_count = 1
  }

  core_instance_group {
    instance_type = "m4.large"
    instance_count = 2
  }

  configurations_json = <<EOF
  [
    {
      "Classification": "spark",
      "Properties": {
        "maximizeResourceAllocation": "true"
      }
    }
  ]
  EOF

  bootstrap_action {
    path = "s3://your-bucket-path/bootstrap-actions.sh"
  }

  log_uri = "s3://${aws_s3_bucket.emr_bucket.bucket}/logs/"

  step {
    name = "Setup Hadoop Debugging"
    action_on_failure = "TERMINATE_CLUSTER"
    hadoop_jar_step {
      jar = "command-runner.jar"
      args = ["state-pusher-script"]
    }
  }

  tags = {
    Environment = "development"
    Name        = "EMR Cluster"
  }

  depends_on = [aws_s3_bucket.emr_bucket]
}

output "cluster_id" {
  value = aws_emr_cluster.emr_cluster.id
}
