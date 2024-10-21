# EventVerse Infrastructure Setup

This project aims to build the core infrastructure for the EventVerse system, which includes several Azure resources using Terraform. EventVerse is designed to handle event management, with secure and scalable cloud infrastructure.

## Project Overview

The infrastructure for EventVerse is designed with the following main components:

- **Resource Group**: A resource group named `eventverse-rg` was created to organize all Azure resources for this project.
- **Azure Kubernetes Service (AKS)**: An AKS cluster (`eventverse-aks`) was deployed to host and manage containerized microservices. This AKS cluster has one default node pool with `Standard_B2s` VMs for cost-effective testing purposes.
- **Azure SQL Database**: An Azure SQL server (`eventverse-sql-server`) and a SQL database (`eventverse-db`) were deployed to store application data securely. The SQL credentials were securely stored in Azure Key Vault, ensuring sensitive information is not exposed in the codebase.
- **Azure Key Vault**: An Azure Key Vault (`eventverse-keyvault`) was set up to manage secrets for the SQL database, such as administrator username and password, which were referenced in the Terraform configuration.
- **Azure Blob Storage**: An Azure Storage Account (`eventverse-storage`) with a Blob Container (`eventverse-media`) was deployed to store media files related to events.

## Current Progress

### Completed Steps

- **GitHub Repository Setup**: A branch named `infrastructure-setup` was created for all the Terraform code related to the infrastructure deployment.
- **Terraform Configuration**: Wrote Terraform scripts to automate the deployment of Azure resources, including a resource group, AKS cluster, SQL server, SQL database, Key Vault, and Blob Storage.
- **Deployment Verification**: Successfully initialized, validated, and deployed the infrastructure using Terraform. Verified that all resources were created in the Azure Portal.
- **Outputs Defined**: Added output values in Terraform for easy access to key resource information, such as the AKS cluster name, SQL server name, and storage container details.

## Key Features

- **Secure Storage of Credentials**: SQL server credentials are stored in Azure Key Vault, ensuring secure and centralized management of sensitive data.
- **Scalable and Cost-Effective AKS Setup**: The AKS cluster was configured with a small node pool, with options to scale as required for production.
- **Infrastructure as Code (IaC)**: Leveraging Terraform for repeatable and consistent deployment of cloud resources.

## Next Steps

- **Deploy Microservices to AKS**: Continue by deploying the microservices to the AKS cluster using CI/CD pipelines.
- **CI/CD Integration**: Set up Azure DevOps pipelines to automate the deployment process.
- **Testing and Monitoring**: Implement monitoring solutions to ensure stability and availability of the EventVerse infrastructure.

## Prerequisites

- **Terraform**: Ensure you have Terraform installed locally to work with the scripts.
- **Azure CLI**: You need Azure CLI installed to authenticate with your Azure account.
- **Access to GitHub Repository**: The infrastructure code is in the `infrastructure-setup` branch.

## How to Use

1. Clone the repository and navigate to the infrastructure directory.
2. Update the `terraform.tfvars` file with your specific configuration values (e.g., storage account name).
3. Run the following commands to deploy the infrastructure:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
4. Use the output values to verify resources in the Azure Portal.

## Contact

For questions or collaboration, feel free to reach out via GitHub issues or pull requests.
