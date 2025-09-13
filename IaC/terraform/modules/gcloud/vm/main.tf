data "google_service_account" "vms_account" {
  count      = var.vms_account_id != null ? 1 : 0
  account_id = var.vms_account_id
}

resource "google_compute_disk" "compute_disk" {
  name     = var.diskname != null ? var.diskname : var.name
  size     = var.size
  type     = var.type
  zone     = var.zone
  image    = length(var.source_snapshot) > 0 ? null : var.image
  snapshot = length(var.source_snapshot) > 0 ? var.source_snapshot[0] : null
  labels = {
    env = var.env
  }
}

resource "google_compute_resource_policy" "snapshot_policy" {
  count  = var.enable_snapshot_policy ? 1 : 0
  name   = "snapshot-policy-${var.name}"
  region = var.region
  snapshot_schedule_policy {

    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = var.snapshot_start_time
      }
    }
    retention_policy {
      max_retention_days    = 7
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      labels = {
        env = var.env
      }
      storage_locations = ["us"]
      guest_flush       = true
    }
  }
  depends_on = [google_compute_disk.compute_disk]
}

resource "google_compute_disk_resource_policy_attachment" "disk_policy_attachment" {
  count      = var.enable_snapshot_policy ? 1 : 0
  name       = google_compute_resource_policy.snapshot_policy[0].name
  disk       = google_compute_disk.compute_disk.name
  zone       = var.zone
  depends_on = [google_compute_disk.compute_disk]
}

# https://cloud.google.com/compute/docs/general-purpose-machines
# https://cloud.google.com/compute/docs/regions-zones#available
resource "google_compute_instance" "compute_instance" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  tags                      = var.tags
  allow_stopping_for_update = true
  enable_display            = true # Enable virtual display

  boot_disk {
    source      = google_compute_disk.compute_disk.id
    auto_delete = var.delete_boot_disk
  }

  metadata = {
    block-project-ssh-keys = "TRUE"
    enable-osconfig        = "TRUE"
    ssh-keys               = "ubuntu:${file(var.gce_ssh_pub_key_file)}"
    startup-script         = var.metadata_startup_script
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnetwork_id
    network_ip = var.network_ip

    access_config {
      nat_ip = var.cidr // this adds regional static ip to VM
    }
  }

  dynamic "service_account" {
    for_each = var.vms_account_id != null ? [1] : []
    content {
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      email  = data.google_service_account.vms_account[0].email
      scopes = ["cloud-platform"]
    }
  }

  labels = {
    env = var.env
  }

  # user_data           = file("./gateway.yml")
  resource_policies   = var.resource_policies
  deletion_protection = var.deletion_protection
  depends_on          = [google_compute_disk_resource_policy_attachment.disk_policy_attachment]
}
