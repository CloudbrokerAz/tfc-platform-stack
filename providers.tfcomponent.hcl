# ============================================================================
# Required Providers
# ============================================================================

required_providers {
  tfe = {
    source  = "hashicorp/tfe"
    version = "~> 0.60"
  }
  github = {
    source  = "integrations/github"
    version = "~> 6.0"
  }
}

# ============================================================================
# TFE Provider with Automatic Authentication
# ============================================================================

provider "tfe" "this" {
  config {
    hostname = "app.terraform.io"
    
    # Stack execution context provides automatic authentication
    # No token needed when deploying to same organization
  }
}

# ============================================================================
# GitHub Provider
# ============================================================================

provider "github" "this" {
  config {
    owner = var.github_organization
    token = var.github_token
  }
}
