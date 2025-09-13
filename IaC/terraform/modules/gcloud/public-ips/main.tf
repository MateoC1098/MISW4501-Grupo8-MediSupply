resource "google_compute_address" "compute_address" {
  for_each = { for i, v in var.expected_ips : i => v }

  name         = each.value.name
  address_type = "EXTERNAL"
  description  = each.value.description
  network_tier = "PREMIUM"
  region       = var.region
  project      = var.project
  labels = {
    env = "${each.value.env}"
  }
}
