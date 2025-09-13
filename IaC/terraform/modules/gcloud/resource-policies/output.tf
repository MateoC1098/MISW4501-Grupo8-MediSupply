output "start_stop_policy" {
  value       = google_compute_resource_policy.start_stop_policy.self_link
  description = "Link de referencia para la politica de recursos schedule."
}
