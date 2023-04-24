output "tailscale_subnet_route_instance_name" {
  value       = module.tailscale_subnet_router.instance_name
  description = "The name tag value of the Tailscale Subnet Router EC2 instance."
}
