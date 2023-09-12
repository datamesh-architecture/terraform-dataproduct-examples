module "bigquery_transform" {
  source  = "datamesh-architecture/dataproduct-gcp-bigquery-transform/google"
  version = "0.3.0"

  gcp = {
    project = var.gcp.project
    region  = var.gcp.region
  }

  teamId = "fulfillment"
  name = "shelf_warmers"

  input = {
    source_table = var.source_table
  }
  output = {
    discovery_access = ["allUsers"]
  }
}
