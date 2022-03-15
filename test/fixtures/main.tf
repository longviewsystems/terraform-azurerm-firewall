module "networking" {
  source = "./resources"
}

module "firewall" {
    source                = "../../" # testing root module
    virtual_network       = module.networking.virtual_network
    firewall_subnet_id    = module.networking.firewall_subnet_id
    public_ip_sku         = "Standard"
    }