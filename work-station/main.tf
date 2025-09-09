resource "aws_instance" "work_station" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.work_station_sg.id]

  iam_instance_profile   = "TerraformAdminPermissions"
  user_data              = file("work-station.sh")

   root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  
  tags = {
    Name = "${var.project}"
  }
}


resource "aws_security_group" "work_station_sg" {
  name        = "work_station_sg"
  description = "sg for work-station"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "work_station_sg"
  }
}
