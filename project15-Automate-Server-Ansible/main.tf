provider "aws" {
 region = var.aws_region
}

data "aws_ami" "ubuntu" {
 most_recent = true
 owners      = ["099720109477"]

 filter {
   name   = "name"
   values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
 }

 filter {
   name   = "virtualization-type"
   values = ["hvm"]
 }
}

resource "aws_security_group" "ansible_controller_sg" {
 name        = "ansible-controller-sg"
 description = "SSH access to Ansible controller"

 ingress {
   description = "SSH from my IP"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = [var.my_ip]
 }

 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

 tags = {
   Name = "Ansible-Controller-SG"
 }
}

resource "aws_security_group" "managed_node_sg" {
 name        = "ansible-managed-node-sg"
 description = "SSH from controller and public HTTP"

 ingress {
   description     = "SSH from controller"
   from_port       = 22
   to_port         = 22
   protocol        = "tcp"
   security_groups = [aws_security_group.ansible_controller_sg.id]
 }

 ingress {
   description = "HTTP public access"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

 tags = {
   Name = "Ansible-Managed-SG"
 }
}

resource "aws_instance" "controller" {
 ami                    = data.aws_ami.ubuntu.id
 instance_type           = var.instance_type
 key_name               = var.key_name
 vpc_security_group_ids  = [aws_security_group.ansible_controller_sg.id]

 tags = {
   Name = "Ansible-Controller"
 }
}

resource "aws_instance" "managed_node" {
 ami                    = data.aws_ami.ubuntu.id
 instance_type           = var.instance_type
 key_name               = var.key_name
 vpc_security_group_ids  = [aws_security_group.managed_node_sg.id]

 tags = {
   Name = "Ansible-Managed-Node"
 }
}