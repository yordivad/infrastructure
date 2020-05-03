variable "aws_access_key_id" {
  description = "the aws access key id"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "the aws access secret key"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "the aws access region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name to be used on the Default VPC"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "the CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = string
  default     = ""
}

variable "vpc_public_cidr" {
  description = "A list of public cidr inside the VPC"
  type        = string
  default     = ""
}

variable "vpc_private_cidr" {
  description = "A list of public cidr inside the VPC"
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1a"
    us-west-1 = "us-west-1a"
  }
}

variable "ssh_key_name" {
  type = string
  default = "connect"
}
