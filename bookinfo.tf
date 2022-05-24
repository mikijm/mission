# Download the Istio installer
#resource "null_resource" "deploy_bookinfo" {
  provisioner "local-exec" {
    command = <<EOF
    set -xe
    cd ${path.root}
    kubectl label namespace default istio-injection=enabled
    kubectl apply -f ./istio/samples/bookinfo/platform/kube/bookinfo.yaml
    kubectl apply -f ./samples/bookinfo/networking/bookinfo-gateway.yaml
    kubectl apply -f ./istio/samples/bookinfo/networking/destination-rule-all.yaml
    kubectl apply -f ./istio/samples/addons
    kubectl rollout status deployment/kiali -n istio-system
    EOF
  }
  triggers = {
    build_number = timestamp()
  }
}
