provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"
}

resource "aws_ami_copy" "ami_ubuntu_16_04" {
  name              = "ubuntu-16.04"
  description       = "A copy of the ubuntu 16.04 AMI from Amazon for Baobab"
  source_ami_id     = "ami-0a590332f9f499197"
  source_ami_region = "eu-west-2"
}

resource "aws_security_group" "secgroup_baobab_demo" {
    name = "baobab_demo_secgroup"
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "template_file" "init_script" {
  template = "${file("${path.module}/instance_data.sh")}"
}

resource "aws_instance" "ec2_baobab_demo" {
    ami           = aws_ami_copy.ami_ubuntu_16_04.id
    instance_type = "t2.large" # 2 cores, 8gb RAM, ephemeral
    vpc_security_group_ids = [aws_security_group.secgroup_baobab_demo.id]
    user_data = data.template_file.init_script.rendered
#    root_block_device {
#        volume_size = "50"
#    }
}

output "public_ip" {
  value       = aws_instance.ec2_baobab_demo.public_ip
  description = "The public IP of the baobab server"
}

output "public_dns" {
  value       = aws_instance.ec2_baobab_demo.public_dns
  description = "The public DNS of the baobab server"
}