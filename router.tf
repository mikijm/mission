# Define cloud router which allows internet access to hosts
resource "google_compute_router" "router" {
  name    = "router"
  project = var.project
  region  = google_compute_subnetwork.private.region
  network = google_compute_network.main.id
}
