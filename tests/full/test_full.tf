module "main" {
  source              = "../.."
  burst               = 1024
  description         = "${var.name} Fibre-Channel QoS Policy."
  max_data_field_size = 2112
  name                = var.name
  organization        = "terratest"
  rate_limit          = 0
}
