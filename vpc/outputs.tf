output "network_main" {
  value     = google_compute_network.main.self_link
  sensitive = true
}

output "network_private" {
  value     = google_compute_subnetwork.private.self_link
  sensitive = true
}

