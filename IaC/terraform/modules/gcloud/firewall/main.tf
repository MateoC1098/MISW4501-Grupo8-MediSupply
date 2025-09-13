# ["ssh", "http-server", "https-server"] son default network tags
resource "google_compute_firewall" "internal_in" {
  name = "${var.target_tag}-allow-custom-in"
  allow {
    # sin ports es all-ports
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = [var.ip_cidr_range_1, var.ip_cidr_range_2]
  target_tags   = [var.target_tag]
}

resource "google_compute_firewall" "internal_out" {
  name = "${var.target_tag}-allow-custom-out"
  allow {
    # sin ports es all-ports
    protocol = "tcp"
  }
  direction          = "EGRESS"
  network            = var.network_id
  priority           = 1000
  destination_ranges = [var.ip_cidr_range_1, var.ip_cidr_range_2]
  target_tags        = [var.target_tag]
}

# Para aceptar las conexiones desde https://console.cloud.google.com
resource "google_compute_firewall" "iap_in_ipv4" {
  name = "${var.target_tag}-allow-rdp-ssh-ingress-ipv4"
  allow {
    ports    = var.ssh_custom_port != "" ? concat(["22", "3389"], [var.ssh_custom_port], var.extra_dev_ports) : concat(["22", "3389"], var.extra_dev_ports)
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = concat(var.authorized_ingress_cidr_IPv4, ["35.235.240.0/20"])
  target_tags   = [var.target_tag]
}

resource "google_compute_firewall" "iap_in_ipv6" {
  count = length(var.authorized_ingress_cidr_IPv6) > 0 ? 1 : 0
  name  = "${var.target_tag}-allow-rdp-ssh-ingress-ipv6"
  allow {
    ports    = var.ssh_custom_port != "" ? concat(["22", "3389"], [var.ssh_custom_port], var.extra_dev_ports) : concat(["22", "3389"], var.extra_dev_ports)
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = var.authorized_ingress_cidr_IPv6
  target_tags   = [var.target_tag]
}

resource "google_compute_firewall" "allow_health_checksn_ipv4" {
  name = "${var.target_tag}-allow-health-checks-ipv4"
  allow {
    # sin ports es all-ports
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = ["allow-health-checks"]
}

resource "google_compute_firewall" "http_server_ipv4" {
  name = "${var.target_tag}-http-server-ipv4"
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "http_server_ipv6" {
  name = "${var.target_tag}-http-server-ipv6"
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = ["::/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "https_server_ipv4" {
  name = "${var.target_tag}-https-server-ipv4"
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

resource "google_compute_firewall" "https_server_ipv6" {
  name = "${var.target_tag}-https-server-ipv6"
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 1000
  source_ranges = ["::/0"]
  target_tags   = ["https-server"]
}

resource "google_compute_firewall" "close_ssh_ipv4" {
  count = var.close_22_port ? 1 : 0
  name  = "${var.target_tag}-close-ssh-ipv4"
  deny {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 999
  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.target_tag]
}

resource "google_compute_firewall" "close_ssh_ipv6" {
  count = var.close_22_port ? 1 : 0
  name  = "${var.target_tag}-close-ssh-ipv6"
  deny {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 999
  source_ranges = ["::/0"]
  target_tags   = [var.target_tag]
}

resource "google_compute_firewall" "open_custom_ssh_ipv4" {
  count = var.open_custom_ssh_port && var.ssh_custom_port != "" ? 1 : 0
  name  = "${var.target_tag}-open-custom-ssh-ipv4"
  allow {
    ports    = [var.ssh_custom_port]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 999
  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.target_tag]
}

resource "google_compute_firewall" "open_custom_ssh_ipv6" {
  count = var.open_custom_ssh_port && var.ssh_custom_port != "" ? 1 : 0
  name  = "${var.target_tag}-open-custom-ssh-ipv6"
  allow {
    ports    = [var.ssh_custom_port]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = var.network_id
  priority      = 999
  source_ranges = ["::/0"]
  target_tags   = [var.target_tag]
}

resource "google_compute_firewall" "external_out" {
  name = "${var.target_tag}-allow-external-out"
  allow {
    # sin ports es all-ports
    protocol = "tcp"
  }
  direction   = "EGRESS"
  network     = var.network_id
  priority    = 1000
  target_tags = [var.target_tag]
}
