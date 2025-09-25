locals {
  expected_ips = [
    { name : "vpc-peering-ip", description : "Ip publica de donde acepta trafico la base de datos", env : "prod" }
  ]
}

module "public_ips" {
  source       = "../../modules/gcloud/public-ips"
  project      = var.project
  region       = var.region
  expected_ips = local.expected_ips
}

locals {
  network_name    = "${var.project}-network"
  subnetwork_name = "${var.project}-subnetwork"
  ip_cidr_range_1 = "10.141.0.0/28" # Number of Usable Hosts:	28
  ip_cidr_range_2 = "10.141.1.0/28" # Number of Usable Hosts:	28
  vms_account_id  = "vms-account@${var.project}.iam.gserviceaccount.com"
  machines = [
    {
      name : "developers-db-gateway",
      region : var.region,
      zone : "us-east1-b",
      machine_type : "e2-micro", # [1 - 2(30s)]vCPUs [1] GB Memory; $6.11 USD Month
      tags : ["firewall-${var.project}", "ssh", "http-server", "https-server"],
      size : 10, # GB; $1 USD Month
      type : "pd-ssd",
      network_ip : "10.141.0.2",
      cidr : module.public_ips.ip_addresses[0],
      delete_boot_disk : true,
      resource_policies : [],
      metadata_startup_script : null,
      image : "ubuntu-2404-lts-amd64",
      source_snapshot : [],
      enable_snapshot_policy : true,
      snapshot_start_time : "10:00", # 5:00 AM America/Bogota
      env : "prod"
      deletion_protection : false # para poder usarla efimeramente
    }
  ]
}

module "network" {
  source               = "../../modules/gcloud/vpc"
  network_name         = local.network_name
  network_routing_mode = "GLOBAL"
  subnetwork_name      = local.subnetwork_name
  region               = var.region
  ip_cidr_range_1      = local.ip_cidr_range_1
  ip_cidr_range_2      = local.ip_cidr_range_2
  vpc_peering          = true
}

module "network_firewall" {
  source                       = "../../modules/gcloud/firewall"
  network_id                   = module.network.network_id
  ip_cidr_range_1              = local.ip_cidr_range_1
  ip_cidr_range_2              = local.ip_cidr_range_2
  target_tag                   = "firewall-${var.project}"
  ssh_custom_port              = ""
  authorized_ingress_cidr_IPv4 = ["0.0.0.0/0"]
  authorized_ingress_cidr_IPv6 = ["::/0"]
  close_22_port                = false
  extra_dev_ports              = []
  depends_on                   = [module.network]
}

module "registry_docker" {
  source        = "../../modules/gcloud/registry-docker"
  project       = var.project
  location      = var.region
  repository_id = "${var.project}-container-registry"
  description   = "Repositorio de contenedores Docker para la aplicacion ${var.project}"
  env           = "prod"
}

module "vm" {
  for_each                = { for i, v in local.machines : i => v }
  source                  = "../../modules/gcloud/vm"
  gce_ssh_pub_key_file    = var.gce_ssh_pub_key_file
  network_id              = module.network.network_id
  subnetwork_id           = module.network.subnetwork_compute_engine_id
  vms_account_id          = local.vms_account_id
  region                  = each.value.region
  zone                    = each.value.zone
  name                    = each.value.name
  machine_type            = each.value.machine_type
  tags                    = each.value.tags
  size                    = each.value.size
  type                    = each.value.type
  network_ip              = each.value.network_ip
  cidr                    = each.value.cidr
  delete_boot_disk        = each.value.delete_boot_disk
  resource_policies       = each.value.resource_policies
  metadata_startup_script = each.value.metadata_startup_script
  image                   = each.value.image
  source_snapshot         = each.value.source_snapshot
  enable_snapshot_policy  = each.value.enable_snapshot_policy
  snapshot_start_time     = each.value.snapshot_start_time
  env                     = each.value.env
  deletion_protection     = each.value.deletion_protection
  depends_on              = [module.network]
}

resource "google_pubsub_topic" "pubsub_topic" {
  name = "topic-pedidos"

  message_storage_policy {
    allowed_persistence_regions = [var.region]
    enforce_in_transit          = true
  }

  labels = {
    env = "prod"
  }
}

# db-f1-micro: Maximum Storage Capacity 3062 (GB), Shared Virtual CPUs, 0.6 RAM (GB)
module "database" {
  name                   = "${var.project}db"
  database_version       = "POSTGRES_17"
  source                 = "../../modules/gcloud/database"
  region                 = var.region
  tier                   = "db-f1-micro" # $10.001 USD Month (ZONAL)
  availability_type      = "ZONAL" # "REGIONAL"
  private_network        = module.network.network_id
  reserved_peering_range = module.network.private_ip_address[0].name
  authorizednets = [
    { name : "${var.project}-peering", cidr : module.public_ips.ip_addresses[0] }
  ]
  built_in_admin_user     = "dbadmin"
  built_in_admin_password = var.dbadmin_password
  env                     = "prod"
  ssl_mode                = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"
  deletion_protection     = false
  depends_on              = [module.public_ips, module.network, google_service_networking_connection.networking_connection]
}

resource "google_vpc_access_connector" "vpc_access_connector" {
  name = "vpcaccessdb"
  subnet {
    name = module.network.subnetwork_cloud_run_name
  }
  machine_type  = "e2-micro"
  min_instances = 2
  max_instances = 3
  region        = "us-east1"
  depends_on    = [module.network]
}

/*
resource "google_cloud_run_v2_service" "cloud_run_v2_service_medisupply_api" {
  name                = "medisupply-api"
  location            = "us-east1"
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  scaling {
    max_instance_count = 10
  }
  template {
    containers {
      image = "ghcr.io/mateoc1098/misw4501-grupo8-medisupply/medisupply-api:latest"
      startup_probe {
        initial_delay_seconds = 0
        timeout_seconds       = 1
        period_seconds        = 3
        failure_threshold     = 1
        tcp_socket {
          port = 4000
        }
      }
      liveness_probe {
        http_get {
          path = "/health"
        }
      }
      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
          # "nvidia.com/gpu" = "1"
        }
        # startup_cpu_boost = true
      }
      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project
      }
      env {
        name  = "GOOGLE_APPLICATION_CREDENTIALS"
        value = "../MEDISUPPLY_APPLICATION_ACCOUNT_KEY.json"
      }
    }
    # node_selector {
    #   accelerator = "nvidia-l4"
    # }
    # gpu_zonal_redundancy_disabled = true
  }
  depends_on = [module.database]
}

resource "google_api_gateway_api" "api_gateway_api" {
  provider = google-beta
  api_id   = "${var.project}-api"
}

resource "google_api_gateway_api_config" "api_gateway_api_config" {
  provider      = google-beta
  api           = google_api_gateway_api.api_gateway_api.api_id
  api_config_id = "${var.project}-config"

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("openapi.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
*/