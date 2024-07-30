data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_placement_group" "devops_exercise" {
  name     = "devops_exercise"
  strategy = "Spread"
}

resource "aws_launch_configuration" "devops_exercise" {
  name          = "devops_exercise"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}

resource "aws_autoscaling_group" "devops_exercise" {
  name                      = "devops_exercise"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  placement_group           = aws_placement_group.devops_exercise.id
  launch_configuration      = aws_launch_configuration.devops_exercise
  vpc_zone_identifier       = [aws_subnet.subnet1.id]

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  initial_lifecycle_hook {
    name                 = "devops_exercise"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_target_arn = aws_sns_topic.devops_exercise.arn
    role_arn                = aws_iam_role.devops_exercise.arn
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "project"
    value               = "devops_exercise"
  }
}