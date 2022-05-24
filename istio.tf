# Create Isto Namespace
resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

# Download the Istio installer
#resource "null_resource" "helm_repo" {
#  provisioner "local-exec" {
#    command = <<EOF
#    set -xe
#    cd ${path.root}
#    rm -rf ./istio-${var.istio_helm_release_version} || true
#    curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=${var.istio_helm_release_version} TARGET_ARCH=x86_64 sh -
#    rm -rf ./istio || true
#    mv ./istio-${var.istio_helm_release_version} istio
#    EOF
#  }
#  triggers = {
#    build_number = timestamp()
#  }
#}

# Install Istio Base
resource "helm_release" "istio_base" {
  name            = "istio-base"
  chart           = "./istio/manifests/charts/base"
  version         = var.istio_helm_release_version
  timeout         = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "istio-system"
  values = [
    "${file("istio_values.yaml")}"
  ]
  depends_on      = [kubernetes_namespace.istio_system]
}

# Install istiod
resource "helm_release" "istiod" {
  name            = "istiod"
  chart           = "./istio/manifests/charts/istio-control/istio-discovery"
  timeout         = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "istio-system"
  values = [
    "${file("istio_values.yaml")}"
  ]
  depends_on      = [kubernetes_namespace.istio_system, helm_release.istio_base]
}

# Install Istio Ingress
resource "helm_release" "istio_ingress" {
  name            = "istio-ingress"
  chart           = "./istio/manifests/charts/gateways/istio-ingress"
  timeout         = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "istio-system"
  values = [
    "${file("istio_values.yaml")}"
  ]
  depends_on      = [kubernetes_namespace.istio_system, helm_release.istiod]
}
