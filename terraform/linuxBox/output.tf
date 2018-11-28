output "login_to_box" {
  #value = "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
  value = "${format("ssh ubuntu@%s", google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip)}"
}
