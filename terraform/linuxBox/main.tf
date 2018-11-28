terraform {
  backend "gcs" {
    bucket  = "cd-playground"
    prefix  = "terraform/linuxBoxTest"
    credentials = "./cd-playground-ec6d5798549b.json"
  }
}
resource "google_compute_instance" "vm_instance" {
  count        = "${var.count}"
  name         = "linux-box"
  zone         = "us-central1-c"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config = {
    }
  }

  metadata_startup_script = <<SCRIPT
#!/bin/bash

sudo apt-get remove docker docker-engine -y
sudo apt-get update -y
sudo apt-get install -y \
   linux-image-extra-$(uname -r) \
   linux-image-extra-virtual
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y
sudo apt-get install docker-ce python-pip openjdk-8-jre-headless -y
sudo pip install docker-compose

sudo usermod -aG docker ${var.username} || true
SCRIPT

  metadata {
    sshKeys = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
  }

}
 
