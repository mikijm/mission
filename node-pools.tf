# Define dedicated service account
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
  project = var.project
}

# Define first node pool general to run cluster components 
resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.primary.id

  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Define second instance group to applications
resource "google_container_node_pool" "apps" {
  name    = "apps"
  cluster = google_container_cluster.primary.id

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    labels = {
      role = "apps"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
