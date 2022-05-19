# Define some outputs that include details around the GKE cluster
output "network_main" {
  value     = google_compute_network.main.self_link
}

output "network_private" {
  value     = google_compute_subnetwork.private.self_link
}

output "client_certificate" {
  value     = google_container_cluster.primary.master_auth.0.client_certificate
  description = "client_certificate"
}

output "client_key" {
  value     = google_container_cluster.primary.master_auth.0.client_key
  description = "client_key"
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  description = "ca_certificate"
}

output "host" {
  value     = google_container_cluster.primary.endpoint
  description = "host"
}
