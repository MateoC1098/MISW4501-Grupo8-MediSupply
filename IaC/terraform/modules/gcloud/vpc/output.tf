output "network_id" {
  value       = google_compute_network.compute_network.id
  description = "El ID de la red VPC creada."
}

output "subnetwork_compute_engine_id" {
  value       = google_compute_subnetwork.compute_subnetwork_compute_engine.id
  description = "El ID de la subred principal de la red VPC creada."
}

output "subnetwork_compute_engine_name" {
  value       = google_compute_subnetwork.compute_subnetwork_compute_engine.name
  description = "El nombre de la subred principal de la red VPC creada."
}

output "subnetwork_cloud_run_id" {
  value       = google_compute_subnetwork.compute_subnetwork_cloud_run.id
  description = "El ID de la subred principal de la red VPC creada."
}

output "subnetwork_cloud_run_name" {
  value       = google_compute_subnetwork.compute_subnetwork_cloud_run.name
  description = "El nombre de la subred principal de la red VPC creada."
}

output "private_ip_address" {
  value       = google_compute_global_address.private_ip_address
  description = "El nombre de la dirección privada que se compartira con la base de datos."
}
