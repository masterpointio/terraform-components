locals {
  vpc_id             = data.aws_vpc.default.id
  vpc_cidr_block     = data.aws_vpc.default.cidr_block
  private_subnet_ids = toset(data.aws_subnets.private.ids)
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["${module.this.id}-default"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  filter {
    name   = "tag:Attributes"
    values = ["private"]
  }
}
