resource "google_artifact_registry_repository" "native_registry_docker" {
  project       = var.project
  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = "DOCKER"
  docker_config {
    immutable_tags = true
  }
  labels = {
    "env" = var.env
  }
}
