resource "google_os_config_patch_deployment" "patch_deployment" {
  patch_deployment_id = "patch-deployment-${var.sufix}"

  instance_filter {
    instances = var.instances_URIs
  }

  patch_config {
    reboot_config = "ALWAYS"

    apt {
      type = "UPGRADE"
    }

    pre_step {
      linux_exec_step_config {
        local_path = var.pre_step_script_path
      }
    }

    post_step {
      linux_exec_step_config {
        local_path = var.post_step_script_path
      }
    }
  }

  recurring_schedule {
    time_zone {
      id = "America/Bogota"
    }

    time_of_day {
      hours   = 6
      minutes = 15
      seconds = 0
      nanos   = 0
    }

    weekly {
      day_of_week = "TUESDAY"
    }
  }

  duration = "2700s" # 45m

  rollout {
    mode = "CONCURRENT_ZONES"
    disruption_budget {
      percentage = 100
    }
  }
}
