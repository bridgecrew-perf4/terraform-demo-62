provider "azurerm" {
  version = "2.5.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name   = "tf_rg_blobstore"
    storage_account_name  = "tfstorageignaskar"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "tf_test" {
  location = "UK South"
  name = "tfmainrg"
}

resource "azurerm_container_group" "tfcg_test" {
  location            = azurerm_resource_group.tf_test.location
  name                = "weatherapi"
  resource_group_name = azurerm_resource_group.tf_test.name
  
  ip_address_type = "public"
  dns_name_label  = "ignaskarwa"
  os_type         = "Linux"
  
  container {
    name   = "weatherapi"
    image  = "ignaskar/weatherapi"
    cpu    = "1"
    memory = "1"
    
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}