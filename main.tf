data "hcp_packer_version" "rhel8-pgsql-soe" {
  bucket_name  = "RHEL8-pgsql-SOE"
  channel_name = "Development"
}

data "hcp_packer_artifact" "rhel8-pgsql_ap_southeast_2" {
  bucket_name         = "RHEL8-pgsql-SOE"
  platform            = "aws"
  version_fingerprint = data.hcp_packer_version.rhel8-pgsql-soe.fingerprint
  region              = "ap-southeast-2"
}

resource "aws_instance" "rhel-pgsql_instance" {
  ami           = data.hcp_packer_artifact.rhel8-pgsql_ap_southeast_2.external_identifier
  instance_type = var.instance_type
  subnet_id     = data.terraform_remote_state.aws_dev_vpc.outputs.vpc_public_subnets
  key_name      = var.aws_key_pair_name
  tags          = var.ec2_tags
  vpc_security_group_ids = [data.terraform_remote_state.aws_dev_vpc.outputs.security_group-ssh_http_https_allowed] 

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ec2-user -i '${self.ipv4_address},' --private-key ${var.pvt_key} pgsql-config.yml" 
  }

}


