data "amazon-ami" "base" {
  region      = var.aws_region

  filters = {
    architecture                       = var.base_image.architecture
    "block-device-mapping.volume-type" = var.base_image.volume_type
    root-device-type                   = var.base_image.device_type
    virtualization-type                = var.base_image.virtualization_type
    
    name                               =var.base_image.name

  }

  most_recent = true
  owners      = [var.base_image.owner] #canonical aws account id
}