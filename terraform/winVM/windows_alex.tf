terraform {
  backend "gcs" {
    bucket  = "dima-test"
    prefix  = "terraform/windows_alex"
    credentials = "~/.gcp/account.json"
  }
}
resource "google_compute_instance" "vm_instance" {
  name         = "windows_alex"
  zone         = "us-west1-a"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2008-r2"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config = {
    }
  }
}
 
