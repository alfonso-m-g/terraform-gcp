# Terraform provider
variable "region" {
    type = string
    default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-a"
}

variable "project_id" {
    type = string
    default = "qwiklabs-gcp-02-fab1205cbaed"
}

# Instances
variable "instance_names" {
    type = list(string)
    default = ["tf-instance-1" , "tf-instance-2", "tf-instance-455293"]
}

variable "machine_type" {
    type = string
    default = "n1-standard-2"
}

variable "zone_instance" {
    type = string
    default = "us-east1-c"
}

variable "image" {
    type = string
    default = "debian-10-buster-v20220822"
}

variable "script" {
    type = string
    default = <<-EOT
        #!/bin/bash
    EOT
}

variable "allow_stopping_for_update" {
    type = bool
    default = true
}

variable "network" {
    type = string
    default = "tf-vpc-786289"
}

variable "subnetworks" {
    type = list(string)
    default = ["subnet-01", "subnet-02"]
}

# Bucket

variable "name_bucket" {
    type = string
    default = "tf-bucket-930459"
}

# Network
variable "vpc_region" {
    type = string
    default = "us-east1"
}