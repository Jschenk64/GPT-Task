# locals.tf
locals {
  resource_prefix = "grippo"

  tags = {
    Environment = "Development"
    Project     = "Grippo"
  }
}
