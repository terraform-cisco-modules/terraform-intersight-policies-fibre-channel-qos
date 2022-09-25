module "fibre_channel_qos" {
  source  = "terraform-cisco-modules/policies-fibre-channel-qos/intersight"
  version = ">= 1.0.1"

  burst               = 1024
  description         = "default Fibre Channel QoS Policy."
  max_data_field_size = 2112
  name                = "default"
  organization        = "default"
  rate_limit          = 0
}
