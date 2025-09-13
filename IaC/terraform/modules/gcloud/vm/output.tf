output "machine_id" {
  value       = google_compute_instance.compute_instance.id
  description = "id de la VM."
}
