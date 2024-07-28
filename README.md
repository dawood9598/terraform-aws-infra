# terraform-backend-app
This repository contains Terraform configurations for setting up and managing the backend infrastructure of an application on AWS. It includes configurations for VPC, EC2 instances, Auto Scaling Groups, and SNS. The aim is to provide a scalable and reliable infrastructure using infrastructure as code.

# Resources

## VPC
The vpc.tf file contains configurations to set up a Virtual Private Cloud (VPC) with necessary subnets, route tables, and gateways.
## EC2
The ec2.tf file contains configurations to provision EC2 instances within the VPC.
## ASG
The asg.tf file contains configurations to set up an Auto Scaling Group (ASG) for managing the number of EC2 instances based on load.
## SNS
The sns.tf file contains configurations to set up Simple Notification Service (SNS) for sending notifications based on events.