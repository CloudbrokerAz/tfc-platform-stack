# ============================================================================
# Identity Tokens for OIDC Authentication
# ============================================================================

identity_token "tfe" {
  audience = ["platform.onboarding"]
}

identity_token "github" {
  audience = ["platform.onboarding"]  # Same audience for GitHub operations
}

# Access the 'stacks-varset' variable set to retrieve role_arn
store "varset" "platform_team_config" {
  name     = "platform_team"
  category = "terraform"
}

# ============================================================================
# Local Values
# ============================================================================

locals {
  # Common configuration
  organization        = "cloudbrokeraz"
  github_organization = "CloudbrokerAz"
  platform_project    = "Platform_Team"
  
  # Commit configuration
  commit_author_name  = "Platform Team"
  commit_author_email = "platform-team@cloudbrokeraz.com"
  
  # Repository configuration
  create_bu_repositories   = true
  bu_stack_repo_prefix     = "tfc"
  bu_stack_repo_suffix     = "bu-stack"
  enable_branch_protection = true
  
  # YAML Configuration Content - Embedded as strings (file() not available in .tfdeploy.hcl)
  finance_yaml = <<-EOT
    business_unit: finance

    bu_projects:
      - project_name: "payment-gateway"
        project_description: "Payment processing infrastructure"
      
      - project_name: "financial-reporting"
        project_description: "Financial reporting and analytics infrastructure"
  EOT
  
  engineering_yaml = <<-EOT
    business_unit: engineering

    bu_projects:
      - project_name: "platform-services"
        project_description: "Core platform services and infrastructure"
      
      - project_name: "developer-tools"
        project_description: "Developer productivity and tooling infrastructure"
      
      - project_name: "api-gateway"
        project_description: "API gateway and service mesh infrastructure"
  EOT
  
  sales_yaml = <<-EOT
    business_unit: sales

    bu_projects:
      - project_name: "crm-platform"
        project_description: "Customer relationship management platform infrastructure"
      
      - project_name: "analytics-pipeline"
        project_description: "Sales analytics and reporting pipeline"
      
      - project_name: "sales-portal"
        project_description: "Sales team portal and tools infrastructure"
  EOT
}

# ============================================================================
# Deployment: Finance BU
# ============================================================================

deployment "finance" {
  inputs = {
    # Organization
    tfc_organization_name = local.organization
    
    # Filter to finance business unit
    business_unit = "finance"
    
    # YAML Configuration - Reference local variable
    yaml_config_content = local.finance_yaml
    
    # OIDC tokens
    tfe_identity_token = store.varset.platform_team_config.tfe_identity_token
    github_token       = store.varset.platform_team_config.github_token
    
    # GitHub repository creation
    create_bu_repositories   = local.create_bu_repositories
    github_organization      = local.github_organization
    bu_stack_repo_prefix     = local.bu_stack_repo_prefix
    bu_stack_repo_suffix     = local.bu_stack_repo_suffix
    enable_branch_protection = local.enable_branch_protection
    
    # Platform configuration
    platform_project_name = local.platform_project
    
    # Commit author
    commit_author_name  = local.commit_author_name
    commit_author_email = local.commit_author_email
  }
}

# ============================================================================
# Deployment: Engineering BU
# ============================================================================

deployment "engineering" {
  inputs = {
    # Organization
    tfc_organization_name = local.organization
    
    # Filter to engineering business unit
    business_unit = "engineering"
    
    # YAML Configuration - Reference local variable
    yaml_config_content = local.engineering_yaml
    
    # OIDC tokens
    tfe_identity_token = store.varset.platform_team_config.tfe_identity_token
    github_token       = store.varset.platform_team_config.github_token
    
    # GitHub repository creation
    create_bu_repositories   = local.create_bu_repositories
    github_organization      = local.github_organization
    bu_stack_repo_prefix     = local.bu_stack_repo_prefix
    bu_stack_repo_suffix     = local.bu_stack_repo_suffix
    enable_branch_protection = local.enable_branch_protection
    
    # Platform configuration
    platform_project_name = local.platform_project
    
    # Commit author
    commit_author_name  = local.commit_author_name
    commit_author_email = local.commit_author_email
  }
}

# ============================================================================
# Deployment: Sales BU
# ============================================================================

deployment "sales" {
  inputs = {
    # Organization
    tfc_organization_name = local.organization
    
    # Filter to sales business unit
    business_unit = "sales"
    
    # YAML Configuration - Reference local variable
    yaml_config_content = local.sales_yaml
    
    # OIDC tokens
    tfe_identity_token = store.varset.platform_team_config.tfe_identity_token
    github_token       = store.varset.platform_team_config.github_token
    
    # GitHub repository creation
    create_bu_repositories   = local.create_bu_repositories
    github_organization      = local.github_organization
    bu_stack_repo_prefix     = local.bu_stack_repo_prefix
    bu_stack_repo_suffix     = local.bu_stack_repo_suffix
    enable_branch_protection = local.enable_branch_protection
    
    # Platform configuration
    platform_project_name = local.platform_project
    
    # Commit author
    commit_author_name  = local.commit_author_name
    commit_author_email = local.commit_author_email
  }
}

