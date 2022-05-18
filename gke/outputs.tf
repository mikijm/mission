output "client_certificate" {
  value     = google_container_cluster.primary.master_auth.0.client_certificate
  description = "client_certificate"
  sensitive = true
}

output "client_key" {
  value     = google_container_cluster.primary.master_auth.0.client_key
  description = "client_key"
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  description = "ca_certificate"
  sensitive = true
}

output "host" {
  value     = google_container_cluster.primary.endpoint
  description = "host"
  sensitive = true
}
