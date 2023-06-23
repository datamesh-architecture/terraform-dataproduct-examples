// download JSON from remote endpoint
data "http" "input" {
  url = "<data_product_endpoint>"

  request_headers = {
    Accept = "application/json"
  }
}

module shelf_warmers {
  source  = "datamesh-architecture/dataproduct-aws-athena/aws"
  version = "0.1.0"

  aws      = var.aws

  domain   = "fulfillment"
  name     = "shelf_warmers"
  schedule = "0 0 * * ? *" # Run at 00:00 am (UTC) every day

  input = [
    {
      source = "s3://<s3-bucket>"
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
