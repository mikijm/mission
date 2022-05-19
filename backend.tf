# Store the terraform state date in Google Cloud Storage
terraform {
  backend "gcs" {
    bucket  = "mimann-tf-state"
    prefix  = "mission"
  }
}
