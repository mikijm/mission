resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  project = var.project
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  project = var.project
}

resource "google_compute_network" "main" {
  name                            = "main"
  project = var.project
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
