provider "google" {
  credentials = "${file("./cd-playground-ec6d5798549b.json")}"
  project     = "cd-playground"
  region      = "us-central1"
}

terraform {
  backend "gcs" {
    bucket  = "cd-playground"
    prefix  = "terraform/linuxBox"
    credentials = "cd-playground-ec6d5798549b.json"
  }
}
