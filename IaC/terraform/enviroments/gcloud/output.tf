output "gateway_ip_addresses" {
  value       = module.public_ips.ip_addresses[0]
  description = "IP address of the gateway."
}
