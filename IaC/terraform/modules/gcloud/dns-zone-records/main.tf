resource "google_dns_managed_zone" "dns_managed_zone" {
  name        = replace(var.domain, ".", "-")
  dns_name    = "${var.domain}."
  description = "${title(var.domain)} DNS zone"
  dnssec_config {
    kind  = "dns#managedZoneDnsSecConfig"
    state = "on"
  }
}

resource "google_dns_record_set" "a" {
  for_each     = { for k, v in var.a_records : k => v }
  name         = each.value.name == "@" ? google_dns_managed_zone.dns_managed_zone.dns_name : "${each.value.name}.${google_dns_managed_zone.dns_managed_zone.dns_name}"
  managed_zone = google_dns_managed_zone.dns_managed_zone.name
  type         = "A"
  ttl          = 1800
  rrdatas      = [each.value.ip]
}

resource "google_dns_record_set" "cname" {
  for_each     = { for k, v in var.cname_records : k => v }
  name         = each.value.name == "@" ? google_dns_managed_zone.dns_managed_zone.dns_name : "${each.value.name}.${google_dns_managed_zone.dns_managed_zone.dns_name}"
  managed_zone = google_dns_managed_zone.dns_managed_zone.name
  type         = "CNAME"
  ttl          = 1800
  rrdatas      = [each.value.alias]
}
