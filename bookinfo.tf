# Download the Istio installer
resource "null_resource" "deploy_bookinfo" {
  provisioner "local-exec" {
    command = <<EOF
    set -xe
    cd ${path.root}
    sleep 20
    gcloud container clusters get-credentials primary --region us-east1 --project semiotic-vial-350421
    kubectl label namespace default istio-injection=enabled --overwrite
    kubectl apply -f ./istio/samples/bookinfo/platform/kube/bookinfo.yaml
    kubectl apply -f ./istio/samples/bookinfo/platform/kube/bookinfo-db.yaml
    kubectl apply -f ./istio/samples/bookinfo/networking/bookinfo-gateway.yaml
    kubectl apply -f ./istio/samples/bookinfo/networking/destination-rule-all.yaml
    kubectl apply -f ./istio/samples/addons
    kubectl rollout status deployment/kiali -n istio-system
    EOF
  }
  triggers = {
    build_number = timestamp()
  }
  depends_on = [google_container_node_pool.apps]
}
