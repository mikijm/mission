#resource "google_storage_bucket" "default" {
#  name          = "mission-tf-state"
#  force_destroy = false
#  location      = "US"
#  storage_class = "STANDARD"
#  versioning {
#    enabled = true
#  }
#}

#terraform {
#  backend "gcs" {
#    bucket  = "mission-tf-state"
#    prefix  = "mission/state"
#  }
#}
