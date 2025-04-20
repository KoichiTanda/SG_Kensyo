resource "aws_security_group" "eks_node" {
  name        = "eks-node"
  description = "test security group"
  vpc_id      = "vpc-038a8123f2f59e299"

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = concat(
      [for i in module.security_group : i.security_group_id]
    )
  }
}