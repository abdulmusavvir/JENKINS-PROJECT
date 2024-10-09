variable "cidr_block" {
  description = "VPC CIDR block"
}

variable "region" {
  type        = string
  description = "The name of the region, such as eu-central-1, in which to deploy the vpc"
}

variable "shared_credentials_files" {
  type        = list(string)
  description = "the path of the shared credentials file. If this is not set a profile is specified, ~/.aws/credentials will be used"
}

variable "profile" {
  type        = string
  description = "the aws profile name as set in the shared credentials file"
}

variable "vpc_name" {
  type        = string
  description = "Ensure that your vpc is using appropriate naming for tagging to manage it more efficiently and ahere to AWS resource tagging best practices."
}

variable "author" {
  type        = string
  description = "Name of the owner of the VPC. It's optional but it's recommended to tag your AWS resources to track the monthly costs by owner or environment."
}

variable "private_subnets_counts" {
  type        = number
  description = "number of private subnets to create"
}

variable "public_subnets_counts" {
  type        = number
  description = "number of public subnets to create"
}

variable "availability_zone" {
  type        = list(any)
  description = "Availability zone for spinning up the vpc subnets"
}

variable "public_key" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}


variable "jenkins_master_instance_type" {
  type        = string
  description = "Jenkins master EC2 instance type"
}
