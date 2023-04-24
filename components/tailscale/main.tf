module "tailscale_subnet_router" {
  source  = "git::https://github.com/masterpointio/terraform-aws-tailscale.git?ref=tags/0.1.0"
  context = module.this.context

  name = "tailscale-subnet-router"

  vpc_id                  = local.vpc_id
  advertise_routes        = [local.vpc_cidr_block]
  subnet_ids              = local.private_subnet_ids
  key_pair_name           = coalesce(var.tailscale_existing_ssh_key_name, module.ssh_key_pair.key_name)
  session_logging_enabled = var.tailscale_session_logging_enabled
}

module "ssh_key_pair" {
  source  = "cloudposse/key-pair/aws"
  version = "0.18.3"
  context = module.this.context
  enabled = var.tailscale_existing_ssh_key_name == null

  name = "tailscale-subnet-router"

  ssh_public_key_path = var.ssh_public_key_path
  ssh_public_key_file = var.ssh_public_key_file
  generate_ssh_key    = var.generate_ssh_key
}
