##############################################
#################### VPC #####################
##############################################
resource "aws_vpc" "vpc" {
  count = "${var.create_vpc ? 1 : 0}"

  cidr_block           = "${var.cidr_block}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

###########################################################
#################### Internet gateway #####################
###########################################################
resource "aws_internet_gateway" "igw" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

#############################################################
#################### Public route table #####################
#############################################################
resource "aws_route_table" "public_route_table" {
  count  = "${var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

#############################################################
##################private route table #######################
#############################################################
resource "aws_route_table" "private_route_table" {
  count  = "${var.create_vpc && length(var.private_subnets) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

#############################################################
##################  public subnet   #########################
#############################################################
resource "aws_subnet" "public_subnet" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(concat(var.public_subnets, list("")), count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  tags = "${merge(map("Name", format("%s-${var.public_subnet_suffix}", var.name)), var.tags)}"
}

#############################################################
################## private subnet  ##########################
#############################################################
resource "aws_subnet" "private_subnet" {
  count = "${var.create_vpc && length(var.private_subnets) > 0 ? 1 : 0}"

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(concat(var.private_subnets, list("")), count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  tags              = "${merge(map("Name", format("%s-${var.private_subnet_suffix}", var.name)), var.tags)}"
}

############################################################################
################## public route table association ##########################
############################################################################

resource "aws_route_table_association" "public" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

############################################################################
################# private route table association ##########################
############################################################################
resource "aws_route_table_association" "private" {
  count = "${var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
