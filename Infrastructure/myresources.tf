# Create a resource group
# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name
#   location = "northeurope"
# }

# Logic App defined in the same file
resource "azurerm_logic_app_workflow" "law" {
  name                = "nibe-logicapp-0"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_logic_app_trigger_http_request" "trigger" {
  name         = "nibe-logicapp-0-http-trigger"
  logic_app_id = azurerm_logic_app_workflow.law.id
  schema       = "{}"
}

resource "azurerm_logic_app_action_http" "action" {
  name         = "some-http-action"
  logic_app_id = azurerm_logic_app_workflow.law.id

  method = "GET"
  uri    = "http://example.com"
}

# Another Logic App defined in an exteral file
# resource "azurerm_resource_group_template_deployment" "logicapp" {
#   name                = "nibe-logicapp-1-deployment"
#   resource_group_name = var.resource_group_name
#   template_content    = file("${path.module}/nibe-logicapp-1.json")
#   deployment_mode     = "Incremental"

#   parameters_content = jsonencode({
#     "workflows_nibe_logicapp_1_name" = {
#       value = "nibe-logicapp-1"
#     }
#   })
# }

# Create a resource for an Azure App Service Plan with a name NiBeTerraformAppServicePlan which is a Standard SKU, Linux OS and on the same region as the resource group and is consumption plan
resource "azurerm_service_plan" "app_service_plan" {
  name                = "NiBeFunctionAppServicePlan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name = "Y1"
}

# Create a Storage Account with a name NiBeTerraformStorAcc and no replication
resource "azurerm_storage_account" "storageaccount" {
  name                     = "nibeterraformstoracc"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Terraform resource for an Azure Function App with a name NiBeFunctionApp, NodeJS runtime and consumption plan
resource "azurerm_linux_function_app" "functionapp" {
  name                      = "NiBeFunctionApp"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id           = azurerm_service_plan.app_service_plan.id
  storage_account_name      = azurerm_storage_account.storageaccount.name
  storage_account_access_key = azurerm_storage_account.storageaccount.primary_access_key
  site_config {}
}

# Create a virtual network
# resource "azurerm_virtual_network" "vnet" {
#   name                = "NiBeTerraformVnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = var.location
#   resource_group_name = var.resource_group_name
# }

# output "resource_group_id" {
#   value = azurerm_resource_group.rg.id
# }
