resource "aws_elb" "jenkins_elb" {
  subnets                   = [for subnet in aws_subnet.public_subnets : subnet.id]
  cross_zone_load_balancing = true
  security_groups           = [aws_security_group.elb_jenkins_sg.id]
  instances                 = [aws_instance.jenkins_master.id]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 5
  }
  tags = {
    Name   = "jenkins_elb"
    Author = var.author
  }
}



resource "aws_security_group" "elb_jenkins_sg" {
  name        = "elb_jenkins_sg"
  description = "Allow http traffic"
  vpc_id      = aws_vpc.default-vpc.id
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "elb_jenkins_sg"
    Author = var.author
  }
}
