variable "aws_region" {
  type = string
}

variable "builder_instance_type" {
  description = "the builder instance type"
  type = string
}

variable "created_image_name" {
  description = "the name for the output image"
  type = string
  default = "nomad-ami"
}

variable "base_image" {
  description = "(Optional) attributes for filtering for base builder image"
  type = object({
    architecture = string
    volume_type = string
    device_type = string
    virtualization_type = string
    name = string
    owner = string
  })

  # ubuntu
  default = {
    architecture = "x86_64" # intel
    volume_type = "gp2"
    device_type = "ebs"
    virtualization_type = "hvm"
    name = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
    owner = "099720109477" # canonical aws account id
  }
}