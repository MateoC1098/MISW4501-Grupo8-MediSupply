resource "google_storage_bucket" "storage_bucket" {
  force_destroy            = false
  location                 = upper(var.region)
  name                     = var.storage_bucket_name
  project                  = var.project
  public_access_prevention = "inherited"
  storage_class            = "STANDARD"
}
