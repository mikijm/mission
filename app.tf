resource "kubernetes_pod" "example" {
  metadata {
    name = "example-test"
    labels = {
      App = "example"
    }
  }

  spec {
    container {
      image = "example/http-echo:0.1.0"
      name  = "example-test"

      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "example-test"
  }
  spec {
    selector = {
      App = "${kubernetes_pod.example.metadata.0.labels.App}"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
