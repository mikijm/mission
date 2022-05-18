resource "google_compute_router" "router" {
  name    = "router"
  project = var.project
  network = google_compute_network.main.id
}
