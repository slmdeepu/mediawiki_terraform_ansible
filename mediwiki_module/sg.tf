resource "aws_security_group" "sg" {
  name   = "${var.sg_name}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(var.tags,  
    map("Name", "vpc-sg", "Description", var.description_tag))}"
}

resource "aws_security_group_rule" "vpc_ingress_rule_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = ["${var.cidr_block}"]

  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group_rule" "vpc_ingress_rule_db" {
  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  cidr_blocks = ["${var.cidr_block}"]

  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group_rule" "vpc_egress_rule" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = ["${var.cidr_block}"]

  security_group_id = "${aws_security_group.sg.id}"
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name   = "${var.ec2_sg_name}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(var.tags,  
    map("Name", "ec2-sg", "Description", var.description_tag))}"
}

resource "aws_security_group_rule" "ec2_ingress_rule" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = ["${var.cidr_block}"]

  security_group_id = "${aws_security_group.ec2_sg.id}"
}

resource "aws_security_group_rule" "ec2_egress_rule" {
  type      = "egress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = ["${var.cidr_block}"]

  security_group_id = "${aws_security_group.ec2_sg.id}"
}
