#fetches information about the current AWS region in which Terraform is running
data "aws_region" "current" {}

#creates an AWS VPC IPAM, which is a centralized service to manage IP addressing in your AWS environment. 
resource "aws_vpc_ipam" "devops_exercise" {
  operating_regions {
    region_name = data.aws_region.current.name
  }
}

#creates an IPAM pool, which is a collection of CIDR blocks managed by IPAM.
resource "aws_vpc_ipam_pool" "devops_exercise" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.devops_exercise.private_default_scope_id
  locale         = data.aws_region.current.name
}

#Assigns a specific CIDR block (172.20.0.0/16) to the IPAM pool created earlier. 
resource "aws_vpc_ipam_pool_cidr" "devops_exercise" {
  ipam_pool_id = aws_vpc_ipam_pool.devops_exercise.id
  cidr         = "172.20.0.0/16"
}

#create a VPC (Virtual Private Cloud) using the IPAM pool.
resource "aws_vpc" "devops_exercise" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.devops_exercise.id
  ipv4_netmask_length = 28
  depends_on = [
    aws_vpc_ipam_pool_cidr.test
  ]

  tags = {
    Name = "devops_exercise"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.devops_exercise.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "devops_exercise"
  }
}
