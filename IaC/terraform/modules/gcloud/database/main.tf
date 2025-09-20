resource "google_service_networking_connection" "networking_connection" {
  network                 = var.private_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [var.reserved_peering_range]
}

resource "google_sql_database_instance" "database_instance" {
  name                = var.name
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection

  settings {
    activation_policy     = "ALWAYS"
    availability_type     = var.availability_type
    disk_autoresize       = true
    disk_autoresize_limit = var.disk_autoresize_limit # "1024"   # GB
    tier                  = var.tier                  # # vCPUs, MB
    edition               = var.edition

    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }

      enabled                        = true
      location                       = var.region
      point_in_time_recovery_enabled = substr(var.database_version, 0, length("POSTGRES")) == "POSTGRES"
      start_time                     = "07:00" # 2:00 AM America/Bogota
      transaction_log_retention_days = 3
    }


    ip_configuration {
      ssl_mode        = var.ssl_mode
      private_network = var.private_network

      dynamic "authorized_networks" {
        for_each = var.authorizednets
        iterator = authorizednet

        content {
          name  = "authorized-${authorizednet.key + 1}:${authorizednet.value.name}"
          value = authorizednet.value.cidr
        }
      }
    }
    user_labels = {
      env = var.env
    }
  }
  // depends_on = [google_service_networking_connection.networking_connection]
}

resource "google_sql_user" "sql_user" {
  count      = var.built_in_admin_user != null ? 1 : 0
  name       = var.built_in_admin_user
  instance   = google_sql_database_instance.database_instance.name
  password   = var.built_in_admin_password
  type       = "BUILT_IN"
  depends_on = [google_sql_database_instance.database_instance]
}
