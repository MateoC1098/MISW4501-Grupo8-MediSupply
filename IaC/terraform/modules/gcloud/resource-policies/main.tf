resource "google_compute_resource_policy" "start_stop_policy" {
  name        = "start-stop-resource-policy-${var.sufix}"
  region      = var.region
  description = "Start and stop arenero."
  instance_schedule_policy {
    vm_start_schedule {
      schedule = var.start_schedule
    }
    vm_stop_schedule {
      schedule = var.stop_schedule
    }
    time_zone = "America/Bogota"
  }
}
