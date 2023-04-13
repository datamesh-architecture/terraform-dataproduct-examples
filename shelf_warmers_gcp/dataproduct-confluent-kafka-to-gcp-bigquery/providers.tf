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
  zone    = var.gcp.zone
}

provider "confluent" {
  cloud_api_key    = var.confluent.cloud_api_key
  cloud_api_secret = var.confluent.cloud_api_secret
}
