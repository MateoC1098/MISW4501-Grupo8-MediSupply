resource "google_compute_network" "compute_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = var.network_routing_mode
  mtu                     = 1460
}

resource "google_compute_subnetwork" "compute_subnetwork_compute_engine" {
  name                     = "${var.subnetwork_name}-compute-engine"
  ip_cidr_range            = var.ip_cidr_range_1
  region                   = var.region
  network                  = google_compute_network.compute_network.id
  private_ip_google_access = true

  dynamic "log_config" {
    for_each = var.log_subnetwork ? [1] : []
    content {
      aggregation_interval = "INTERVAL_5_SEC"
      filter_expr          = var.filter_expr
      flow_sampling        = 0.5
      metadata             = "INCLUDE_ALL_METADATA"
    }
  }
}

resource "google_compute_subnetwork" "compute_subnetwork_cloud_run" {
  name                     = "${var.subnetwork_name}-cloud-run"
  ip_cidr_range            = var.ip_cidr_range_2
  region                   = var.region
  network                  = google_compute_network.compute_network.id
  private_ip_google_access = true

  dynamic "log_config" {
    for_each = var.log_subnetwork ? [1] : []
    content {
      aggregation_interval = "INTERVAL_5_SEC"
      filter_expr          = var.filter_expr
      flow_sampling        = 0.5
      metadata             = "INCLUDE_ALL_METADATA"
    }
  }
}

resource "google_compute_global_address" "private_ip_address" {
  count         = var.vpc_peering ? 1 : 0
  name          = "private-ip-address-${var.network_name}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.compute_network.id
}
