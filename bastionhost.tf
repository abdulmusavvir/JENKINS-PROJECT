data "aws_ami" "bastion-host" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_key_pair" "management_id" {
  key_name   = "management"
  public_key = file(var.public_key)

}

resource "aws_security_group" "bastion_host_sg" {
  name        = "bastion_sg_${var.vpc_name}"
  description = "Allow SSH from anywhere"
  vpc_id      = aws_vpc.default-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "bastion_sg_${var.vpc_name}"
    Author = var.author
  }
}


resource "aws_instance" "bastion-host" {
  ami                         = data.aws_ami.bastion-host.id
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.management_id.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_host_sg.id]
  subnet_id                   = element(aws_subnet.public_subnets, 0).id
  associate_public_ip_address = true
  tags = {
    Name   = "bastion"
    Author = var.author
  }
}

