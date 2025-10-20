provider "google" {
    project = var.project_id
    region = var.region
  
}

resource "google_compute_instance" "jenkins" {
    name = "jenkins-server"
    machine_type = "e2-medium"
    zone = var.zone
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2204-lts"
        size = 30
      }
    }

    network_interface {
      network = var.vpc
      subnetwork = var.subnet
      access_config {

      }
    }

    tags = [ "jenkins" ]

    service_account {
      email = "jenkins-sa@cloudregops.iam.gserviceaccount.com"
      scopes = [ "cloud-platform" ]
    }
  
}

resource "google_compute_firewall" "jenkins_fw" {
    name = "allow-jenkins"
    network = var.vpc

    allow {
      protocol = "tcp"
      ports = ["8080", "22"]
    }

    source_ranges = [ "0.0.0.0/0" ]

    target_tags = ["jenkins"]
}

