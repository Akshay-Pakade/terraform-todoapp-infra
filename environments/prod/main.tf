locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "prod"
  }
}

module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = "prod-rg-todoapp-001"
  rg_location = "centralindia"
  rg_tags     = local.common_tags
}

module "rg1" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = "prod-rg-todoapp-002"
  rg_location = "centralindia"
  rg_tags     = local.common_tags
}

module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = "acrprod0075"
  rg_name    = "prod-rg-todoapp-001"
  location   = "centralindia"
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-prod-todoapp0075"
  rg_name         = "prod-rg-todoapp-001"
  location        = "centralindia"
  admin_username  = "prodopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-prod-todoapp00756"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

module "aks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = "aks-prod-todoapp-0075"
  location   = "centralindia"
  rg_name    = "prod-rg-todoapp-001"
  dns_prefix = "aks-prod-todoapp-0075"
  tags       = local.common_tags
}


module "pip" {
  source   = "../../modules/azurerm_public_ip"
  pip_name = "pip-prod-todoapp0075"
  rg_name  = "prod-rg-todoapp-001"
  location = "centralindia"
  sku      = "Basic"
  tags     = local.common_tags
}
