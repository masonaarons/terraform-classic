resource "aws_instance" "main_instance" {
  # AMI  
  ami = data.aws_ssm_parameter.instance_ami.value
  # instance type
  instance_type = "t3.micro"
  # key name
  key_name = "maarons"
  # security group
  vpc_security_group_ids = [aws_default_security_group.main.id]
  # subnet
  subnet_id = aws_subnet.public[0].id
  # Tags
  tags = {
    "Name" = "${var.default_tags.username}-EC2"
  }
  # userdata
  user_data = file("${path.module}/user.sh")
}

resource "aws_default_security_group" "main" {
  vpc_id = aws_vpc.main.id
  #ingress
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  # Ingress HTTP
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }
  #egress ALL TRAFFIC
  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }
}