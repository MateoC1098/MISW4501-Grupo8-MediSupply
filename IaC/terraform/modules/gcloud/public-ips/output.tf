output "ip_addresses" {
  value = [
    for ip in google_compute_address.compute_address : ip.address
  ]
  description = "Un arreglo con cada dirección IP creada."
}
