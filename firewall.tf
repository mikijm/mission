resource "google_compute_firewall" "istio-allow" {
  name    = "istio"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["15017"]
  }

  source_ranges = ["0.0.0.0/0"]
}
