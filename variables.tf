# variables.tf

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.150.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.150.10.0/24", "10.150.20.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.150.30.0/24", "10.150.40.0/24"]
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0084a47cc718c111a"
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "trusted_ip" {
  description = "Trusted IP for SSH access to web instances"
  type        = string
  default     = "0.0.0.0/0" # Replace with your IP
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "Ansi" # Replace with your actual key pair name
}

