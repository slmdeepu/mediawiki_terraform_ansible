resource "aws_instance" "ec2_instance" {
  ami                         = "${var.ami_id}"
  ebs_optimized               = false
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "${var.key_name}"
  subnet_id                   = "${var.subnet_id}"
  source_dest_check           = true

  vpc_security_group_ids = [
    "${aws_security_group.ec2_sg.id}",
  ]

  tags = "${merge(var.tags,
    map("Name", "${var.ec2_instance_name}", "Description", var.description_tag))}"
}


 resource "aws_instance" "db_instance" {
   ami                    = "${var.ami_id}"
   ebs_optimized          = false
   instance_type          = "t2.micro"
   key_name               = "${var.db_key_name}"
   vpc_security_group_ids = ["${aws_security_group.sg.id}"]
   subnet_id              = "${var.subnet_id}"
   tags = "${merge(var.tags,map("Name", "${var.db_instance_name}", "Description", var.description_tag))}"
 }

