# EC2インスタンスの名前リストをローカル変数として定義
locals {
  instance_names = ["server01", "server03"]
}

# AWS公式のEC2モジュールを使用
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  count         = length(local.instance_names)
  name          = local.instance_names[count.index]
  ami           = "ami-05206bf8aecfc7ae6"
  instance_type = "t2.micro"
  vpc_security_group_ids = [module.security_group[count.index].security_group_id]
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"

  count       = length(local.instance_names)
  name        = local.instance_names[count.index]
  description = "egress rule"
  vpc_id      = "vpc-038a8123f2f59e299"

  egress_with_cidr_blocks = [
    {
      from_port   = 7779
      to_port     = 7779
      protocol    = "tcp"
      cidr_blocks = "192.168.1.1/32"
    }
  ]
}
