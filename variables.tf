variable "aws_region" {
  type =  string
  default = "ap-southeast-2"
}

variable "ami_id" {
  type        = string
  default     = "ami-0808460885ff81045" #RHEL8
  description = "The id of the machine image (AMI) to use for the server."

}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "aws_key_pair_name" {
    type = string
    default = "djoo-demo-ec2-keypair"
}

variable "deploy_ssh_private_key" {
   type = string
   description = "ssh private key"
}

variable "ec2_tags" {
  description = "Tags for EC2 instance"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "infraDev"
    Owner = "djoo"
    name = "dev-rhel-ec2"
    Test_Tag = "123"
  }
}


