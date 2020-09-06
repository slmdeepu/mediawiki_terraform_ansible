variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "vpc"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  default     = ["10.0.3.0/28", "10.0.4.0/28"]
}

variable "azs" {
  description = "A list of availability zones in the region"
  default = [""]
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "key_name" {
  default = "serverkey"
}

variable "db_key_name" {
  default = "dbkey"
}

variable "description_tag" {
  default = "Jumphost"
}

variable "subnet_id" {
  default = ""
}

variable "ami_id" {
  default = "ami-07c8bc5c1ce9598c3"
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  default     = "public"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  default     = "private"
}

variable "ec2_sg_name" {
  description = "ec2 sg name"
  default     = "ec2-sg"
}

variable "sg_name" {
  description = "vpc sg name"
  default     = "sg"
}

variable "ec2_instance_name" {
  description = "ec2 instance name"
  default     = "ec2-instance"
}

variable "db_instance_name" {
  description = "ec2 instance name"
  default     = "db-instance"
}

variable "elb_name" {
  description = "elb name"
  default     = "elb"
}

variable "instance_port" {
  description = "instance_port"
  default     = "80"
}

variable "instance_protocol" {
  description = "instance_port"
  default     = "http"
}

variable "lb_port" {
  description = "instance_port"
  default     = "80"
}

variable "lb_protocol" {
  description = "instance_port"
  default     = "http"
}

variable "subnets" {
  description = "A list of subnets for lb"
  default     = []
}

variable "instance_ids" {
  description = "instance ids"
  default     = []
}

