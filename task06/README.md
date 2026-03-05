# Task 06 — SQL Server, Key Vault & Web App

Provisions an Azure SQL Database with secrets stored in Azure Key Vault, connected to an App Service web application. Demonstrates secure secret management patterns.

## Architecture

```
Resource Group
├── Azure Key Vault (referenced from existing KV RG)
│   ├── Secret: sql-admin-name
│   └── Secret: sql-admin-password
├── SQL Module
│   ├── SQL Server (with random password)
│   ├── SQL Database
│   └── Firewall Rule (allow verification IP)
└── WebApp Module
    ├── App Service Plan (Linux, P0v3)
    └── Web App (.NET 8.0)
        └── Connection String → SQL Database
```

## Azure Services
| Service | Purpose |
|---|---|
| Azure SQL Server & Database | Managed relational database |
| Azure Key Vault | Secure storage for SQL credentials |
| App Service + Plan | .NET web application hosting |
| Resource Group | Logical resource container |

## Terraform Concepts Demonstrated
- **`data` blocks** to reference existing resources (Key Vault, client config)
- **`locals`** for name construction with prefixes
- **Modules** for SQL and WebApp separation
- **Key Vault secret management** — storing and retrieving credentials
- **Connection strings** passed between modules
- **Firewall rules** for SQL Server IP whitelisting

## Module Structure
```
task06/
├── main.tf, variables.tf, locals.tf, outputs.tf, versions.tf
└── modules/
    ├── sql/       # SQL Server, Database, Firewall Rules, KV Secrets
    └── webapp/    # App Service Plan, Web App with connection string
```

## Deploy
```bash
terraform init
terraform plan
terraform apply
```

> ⚠️ **Prerequisite**: An Azure Key Vault must already exist in the specified resource group (`kv_rg_name`).
