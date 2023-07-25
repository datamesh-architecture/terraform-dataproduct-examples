// download JSON from remote endpoint
data "http" "input" {
  url = "<kafka-to-s3-discovery-url>"

  request_headers = {
    Accept = "application/json"
  }
}

module shelf_warmers {
  source  = "datamesh-architecture/dataproduct-aws-athena/aws"
  version = "0.2.1"

  aws      = var.aws

  domain   = "fulfillment"
  name     = "shelf_warmers"
  schedule = "0 0 * * ? *" # Run at 00:00 am (UTC) every day

  input = [
    {
      source = jsondecode(data.http.input.response_body)["output"]["location"]
    }
  ]

  transform = {
    query = "sql/transform.sql"
  }

  output = {
    schema   = "schema/shelf_warmers.schema.json"
    format   = "PARQUET"
  }
}

output "discovery_endpoint" {
  value = module.shelf_warmers.discovery_endpoint
}
