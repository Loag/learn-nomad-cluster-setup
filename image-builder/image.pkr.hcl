packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "nomad" {
  region        = var.aws_region

  ami_name      = "${var.created_image_name}-{{timestamp}}"
  instance_type = var.builder_instance_type

  source_ami    = "${data.amazon-ami.base.id}"

  ssh_username  = "ubuntu"

  # 
  force_deregister = true
  force_delete_snapshot = true
  
  tags = {
    Name = "nomad"
    OS = "ubuntu"
    Release = "latest"
    Base_AMI_ID = "{{ .SourceAMI }}"
  }
}

build {
  sources = [
    "source.amazon-ebs.nomad"
  ]

  # make ops dir and set open permissions
  provisioner "shell" {
    inline = [
      "sudo mkdir /ops", 
      "sudo chmod 777 /ops"
    ]
  }

  # copy the shared folder to ops
  provisioner "file" {
    destination = "/ops"
    source      = "shared"
  }

  # set an env var and run the setup script
  provisioner "shell" {
    script           = "shared/scripts/setup.sh"
  }
}
