terraform {
  backend "gcs" {
    bucket  = "tf-bucket-930459"
    prefix  = "terraform/state"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      #version = "3.5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Compute Engine Instances
module "instance1" {
    source = "./modules/instances/"

    instance_name = var.instance_names[0]
    machine_type = var.machine_type
    zone = var.zone_instance
    allow_stopping_for_update = var.allow_stopping_for_update
    image = var.image
    network = var.network
    subnetwork = var.subnetworks[0]
    #script = var.script

    depends_on = [module.vpc]
}

module "instance2" {
    source = "./modules/instances/"

    instance_name = var.instance_names[1]
    # name3 = var.name3
    machine_type = var.machine_type
    zone = var.zone_instance
    allow_stopping_for_update = var.allow_stopping_for_update
    image = var.image
    network = var.network
    subnetwork = var.subnetworks[1]
    #script = var.script

    depends_on = [module.vpc]
}

# Cloud Storage Bucket
module "bucket" {
  source = "./modules/storage"

  name = var.name_bucket
}

# Network
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 3.0"

    project_id   = var.project_id
    network_name = "tf-vpc-786289"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = var.subnetworks[0]
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = var.vpc_region
        },
        {
            subnet_name           = var.subnetworks[1]
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = var.vpc_region
        }
    ]
}

# Firewall
resource "google_compute_firewall" "my_firewall" {
  name    = "tf-firewall"
  network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  depends_on = [module.vpc]
}