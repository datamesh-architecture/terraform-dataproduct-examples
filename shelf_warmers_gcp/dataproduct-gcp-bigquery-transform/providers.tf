terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.59.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = ">= 1.35"
    }
  }
}

provider "google" {
  credentials = file(var.gcp.credentials)

  project = var.gcp.project
  region  = var.gcp.region
}
