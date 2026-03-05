# Task 01 — Azure Portal UI: Windows Server VM & IIS

This foundational task introduces core Azure concepts manually via the **Azure Portal**. It serves as a baseline for understanding how resources are provisioned before moving on to Infrastructure as Code (IaC) with Azure CLI and Terraform in subsequent tasks.

*(Note: Because this task was completed via the UI, this folder contains no Terraform code or scripts.)*

## What Was Covered

### 1. Subscription & Identity Management
- Activated an Azure subscription using Visual Studio Professional benefits.
- Gained familiarity with **Microsoft Entra ID** (formerly Azure Active Directory).
- Created a **Service Principal Name (SPN)** via Azure Cloud Shell and assigned it the `Contributor` and `User Access Administrator` roles at the subscription scope. This SPN's credentials (Client ID, Client Secret, Tenant ID, Subscription ID) were secured for programmatic access in later automation steps.

### 2. Windows Server Virtual Machine (IaaS)
- Provisioned a **Windows Server 2022** Virtual Machine through the Azure Portal.
- Applied cost-optimization practices by selecting the least expensive region using the Azure Pricing Calculator.
- Configured basic networking allowing public connectivity over **RDP (Port 3389)** and **HTTP (Port 80)**.
- Implemented resource tagging (`Creator=your_email@example.com`).

### 3. Application Configuration (IIS)
- Connected to the VM via Windows Remote Desktop (RDP).
- Used Server Manager to install and configure the **IIS Web-Server role** along with specific features:
  - .NET Extensibility 4.8
  - ISAPI Extensions
  - ISAPI Filters
  - ASP.NET 4.8
- Created a custom `server.aspx` file in the IIS root directory containing embedded Visual Basic to dynamically render the server's hostname.

## Architecture Pattern
```
Resource Group
└── Virtual Network
    ├── Network Security Group (Allow RDP/HTTP)
    ├── Public IP
    └── Windows Virtual Machine
        └── IIS Web Server
            └── server.aspx
```

## Significance
This exercise demonstrated the manual steps required to set up a basic web server in the cloud, including identity and access management. Completing this manually provides context for *why* tools like Terraform (introduced in Task 03) and Azure CLI (Task 02) are necessary to automate and scale infrastructure deployments reliably.
