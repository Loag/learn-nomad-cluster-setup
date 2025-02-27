variable "aws_profile" {
  description = "The profile name to use to access aws"
  type = string
}

variable "vpc_finder" {
  description = "Find vpc with tag name = {input name}"
  type = object({
    NAME = string
  })
}

variable "instance_count" {
  description = "How many instances of nomad to create (x2)"
  type = number
  default = 3
}

variable "instance_settings" {
  description = "EC2 instance settings"
  type = object({
    ami = string
    size = string
  })
  default = {
    size = "t2.micro"
  }
}

variable "name" {
  description = "Used to name various infrastructure components"
  default = "nomad"
}

variable "allowlist_ip" {
  description = "IP to allow access for the security groups (set 0.0.0.0/0 for world)"
}

variable "region" {
  description = "The AWS region to deploy to."
  default     = "us-east-1"
}

variable "ami" {
  description = "The AMI to use for the server and client machines."
}

variable "server_instance_type" {
  description = "The AWS instance type to use for servers."
  default     = "t2.micro"
}

variable "client_instance_type" {
  description = "The AWS instance type to use for clients."
  default     = "t2.micro"
}

variable "root_block_device_size" {
  description = "The volume size of the root block device."
  default     = 16
}

variable "key_name" {
  description = "Name of the SSH key used to provision EC2 instances."
}

variable "server_count" {
  description = "The number of servers to provision."
  default     = "3"
}

variable "client_count" {
  description = "The number of clients to provision."
  default     = "3"
}

variable "retry_join" {
  description = "Used by Consul to automatically form a cluster."
  type        = map(string)

  default = {
    provider  = "aws"
    tag_key   = "ConsulAutoJoin"
    tag_value = "auto-join"
  }
}

variable "nomad_binary" {
  description = "Used to replace the machine image installed Nomad binary."
  default     = "none"
}

variable "nomad_consul_token_id" {
  description = "Accessor ID for the Consul ACL token used by Nomad servers and clients."
}

variable "nomad_consul_token_secret" {
  description = "Secret ID for the Consul ACL token used by Nomad servers and clients."
}