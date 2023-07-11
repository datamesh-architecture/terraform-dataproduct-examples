module "bigquery_transform" {
  source = "git@github.com:datamesh-architecture/terraform-google-dataproduct-gcp-bigquery-transform.git"
  gcp = {
    project = var.gcp.project
    region  = var.gcp.region
  }
  domain = "fulfillment"
  name = "shelf_warmers"
  input = {
    source_table = var.source_table
  }
  output = {
    discovery_access = ["allUsers"]
  }
}