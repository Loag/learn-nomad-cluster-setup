data "aws_vpc" "vpc" {
  tags = var.vpc_finder
}

# ec2 service role
data "aws_iam_policy_document" "instance_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "auto_discover_cluster" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "autoscaling:DescribeAutoScalingGroups",
    ]

    resources = ["*"]
  }
}

##################################################
#               Local Files
##################################################

data "template_file" "user_data_server" {
  template = file("${path.module}/user-data-server.sh")

  vars = {
    server_count = var.server_count
    region       = var.region
    retry_join = chomp(join(" ", formatlist("%s=%s", keys(var.retry_join), values(var.retry_join))))
    nomad_binary = var.nomad_binary
    nomad_consul_token_id = var.nomad_consul_token_id
    nomad_consul_token_secret = var.nomad_consul_token_secret
  }
}

data "template_file" "user_data_client" {
  template = file("${path.module}/user-data-client.sh")

  vars = {
    region = var.region
    retry_join = chomp(join(" ",formatlist("%s=%s ", keys(var.retry_join), values(var.retry_join))))
    nomad_binary = var.nomad_binary
    nomad_consul_token_secret = var.nomad_consul_token_secret
  }
}