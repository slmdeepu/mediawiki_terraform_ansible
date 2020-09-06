module "vpc" {
  source       = "../mediwiki/"
  name         = "vpc"
  ami_id       = "ami-0bcc094591f354be2"
  azs          = ["${data.aws_availability_zones.data_az.names[0]}", "${data.aws_availability_zones.data_az.names[1]}", "${data.aws_availability_zones.data_az.names[2]}"]
  subnets      = ["${slice(module.vpc.public_subnets, 0, 1)}"]
  subnet_id    = "${element(module.vpc.public_subnets, 0)}"
  instance_ids = "${module.vpc.instance_id}"
}
