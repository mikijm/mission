variable "username" { default = "admin" }
variable "password" {}
variable "project" {}
variable "region" {}

module "vpc" {
  source  = "./vpc"
  region  = "${var.region}"
  project = "${var.project}"
}

module "gke" {
  source          = "./gke"
  region          = "${var.region}"
  project         = "${var.project}"
  network_main    = "${module.vpc.network_main}"
  network_private = "${module.vpc.network_private}"
}

module "k8s" {
  source                 = "./k8s"
  host                   = "${module.gke.host}"
  username               = "${var.username}"
  password               = "${var.password}"
  client_certificate     = "${module.gke.client_certificate}"
  client_key             = "${module.gke.client_key}"
  cluster_ca_certificate = "${module.gke.cluster_ca_certificate}"
}
