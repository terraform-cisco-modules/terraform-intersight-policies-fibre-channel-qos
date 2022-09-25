#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  for_each = {
    for v in [var.organization] : v => v if length(
      regexall("[[:xdigit:]]{24}", var.organization)
    ) == 0
  }
  name = each.value
}

#__________________________________________________________________
#
# Intersight Fibre Channel QoS Policy
# GUI Location: Policies > Create Policy > Fibre Channel QoS
#__________________________________________________________________

resource "intersight_vnic_fc_qos_policy" "fibre_channel_qos" {
  depends_on = [
    data.intersight_organization_organization.org_moid
  ]
  burst               = var.burst # FI-Attached
  cos                 = var.cos   # Standalone
  description         = var.description != "" ? var.description : "${var.name} Fibre-Channel QoS Policy."
  max_data_field_size = var.max_data_field_size # FI-Attached and Standalone
  name                = var.name
  rate_limit          = var.rate_limit # FI-Attached and Standalone
  organization {
    moid = length(
      regexall("[[:xdigit:]]{24}", var.organization)
      ) > 0 ? var.organization : data.intersight_organization_organization.org_moid[
      var.organization].results[0
    ].moid
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
