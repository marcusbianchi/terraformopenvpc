
variable "aws_region" {
  description = "Used AWS Region."
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "Used CIDR Block Address to VPC."
  default     = "200.0.0.0/16"
}

variable "subnet1_cidr_block" {
  description = "Used CIDR Block Address to the Subnet."
  default     = "200.0.0.0/28"
}

variable "sunet1_availability_zone" {
  description = "Used availability to the Subnet."
  default     = "us-east-1a"
}


variable "subnet2_cidr_block" {
  description = "Used CIDR Block Address to the Subnet."
  default     = "200.0.16.0/28"
}

variable "sunet2_availability_zone" {
  description = "Used availability to the Subnet."
  default     = "us-east-1b"
}

variable "subnet3_cidr_block" {
  description = "Used CIDR Block Address to the Subnet."
  default     = "200.0.32.0/28"
}

variable "sunet3_availability_zone" {
  description = "Used availability to the Subnet."
  default     = "us-east-1c"
}

variable "ec21_private_ip" {
  description = "Ip of  node 1"
  default     = "200.0.0.4"
}


variable "ec2_AMI" {
  description = "AMI used for  Instances"
  default     = "ami-00068cd7555f543d5"
}

variable "ec2_instance_type" {
  description = "Instance type for  Instances"
  default     = "t2.small"
}

variable "ec2_key_name" {
  description = "Key Pair name for  Instances"
  default     = "cratedb-key"
}
