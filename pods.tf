# Define the redis master kubernetes pod
resource "kubernetes_replication_controller" "redis-master" {
  metadata {
    name = "redis-master"
    labels = {
      app  = "redis"
      role = "master"
      tier = "backend"
    }
  }

  spec {
    replicas = 1
    selector = {
      app  = "redis"
      role = "master"
      tier = "backend"
    }
    template {
      metadata {
        labels = {
          app  = "redis"
          role = "master"
          tier = "backend"
        }
      }
      spec {
        container {
          image = "k8s.gcr.io/redis:e2e"
          name  = "master"
          port { 
            container_port = 6379
          }
          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

# Define the redis slave kubernetes pods
resource "kubernetes_replication_controller" "redis-slave" {
  metadata {
    name = "redis-slave"
    labels = {
      app  = "redis"
      role = "slave"
      tier = "backend"
    }
  }

  spec {
    replicas = 2
    selector = {
      app  = "redis"
      role = "master"
      tier = "backend"
    }
    template {
      metadata {
        labels = {
          app  = "redis"
          role = "master"
          tier = "backend"
        }
      }
      spec {
        container {
          image = "gcr.io/google_samples/gb-redisslave:v1"
          name  = "slave"
          port {
            container_port = 6379
          }
          env {
            name  = "GET_HOSTS_FROM"
            value = "dns"
          }
          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

# Define the ingress frontend kubernetes pod
resource "kubernetes_replication_controller" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      app  = "guestbook"
      tier = "frontend"
    }
  }

  spec {
    replicas = 1
    selector = {
      app  = "guestbook"
      tier = "frontend"
    }
    template {
      metadata {
        labels = {
          app  = "guestbook"
          tier = "frontend"
        }
      }
      spec {
        container {
          image = "gcr.io/google-samples/gb-frontend:v4"
          name  = "php-redis"
          port {
            container_port = 80
          }
          env {
            name  = "GET_HOSTS_FROM"
            value = "dns"
          }
          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}
