module "bigquery_transform" {
  source = "git@github.com:datamesh-architecture/terraform-google-dataproduct-gcp-bigquery-transform.git"
  gcp = {
    project = var.gcp.project
    region  = var.gcp.region
  }
  domain = "fulfillment"
  input = {
    source_table = var.source_table
    transform = ["shelf_warmers.sql"]
  }
  output = {
    discovery_access = ["allUsers"]
  }
}
