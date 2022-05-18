resource "google_storage_bucket" "default" {
  name          = "mission-tf-state"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
