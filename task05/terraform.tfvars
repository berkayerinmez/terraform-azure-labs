resource_groups = {
  "rg1" = {
    name     = "cmaz-mod5-rg-01"
    location = "East US"
  }
  "rg2" = {
    name     = "cmaz-mod5-rg-02"
    location = "West US"
  }
  "rg3" = {
    name     = "cmaz-mod5-rg-03"
    location = "Central US"
  }
}

app_service_plans = {
  "asp1" = {
    name         = "cmaz-mod5-asp-01"
    rg_key       = "rg1"
    sku_name     = "S1"
    worker_count = 2
  }
  "asp2" = {
    name         = "cmaz-mod5-asp-02"
    rg_key       = "rg2"
    sku_name     = "S1"
    worker_count = 1
  }
}

app_services = {
  "app1" = {
    name    = "cmaz-mod5-app-01"
    rg_key  = "rg1"
    asp_key = "asp1"
    ip_restrictions = [
      {
        name       = "allow-ip"
        priority   = 100
        action     = "Allow"
        ip_address = "<YOUR_IP_ADDRESS>/32"
      },
      {
        name        = "allow-tm"
        priority    = 200
        action      = "Allow"
        service_tag = "AzureTrafficManager"
      }
    ]
  }
  "app2" = {
    name    = "cmaz-mod5-app-02"
    rg_key  = "rg2"
    asp_key = "asp2"
    ip_restrictions = [
      {
        name       = "allow-ip"
        priority   = 100
        action     = "Allow"
        ip_address = "<YOUR_IP_ADDRESS>/32"
      },
      {
        name        = "allow-tm"
        priority    = 200
        action      = "Allow"
        service_tag = "AzureTrafficManager"
      }
    ]
  }
}

traffic_manager = {
  name              = "cmaz-mod5-traf"
  rg_key            = "rg3"
  routing_method    = "Performance"
  dns_relative_name = "cmaz-mod5-traf"
  dns_ttl           = 60
  monitor_protocol  = "HTTPS"
  monitor_port      = 443
  monitor_path      = "/"
}

tags = {
  Creator = "your_email@example.com"
}
