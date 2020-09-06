resource "aws_elb" "lb" {
  name                        = "${var.elb_name}"
  subnets                     = ["${var.subnets}"]
  security_groups             = ["${aws_security_group.sg.id}"]
  instances                   = ["${var.instance_ids}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.lb_protocol}"
  }
}

