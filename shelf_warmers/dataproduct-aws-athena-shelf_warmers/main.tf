// download JSON from remote endpoint
data "http" "input" {
  url = "<data_product_endpoint>"

  request_headers = {
    Accept = "application/json"
  }
}

module shelf_warmers {
  source = "git@github.com:datamesh-architecture/terraform-dataproduct-aws-athena.git"

  aws      = var.aws

  domain   = "fulfillment"
  name     = "shelf_warmers"
  schedule = "0 0 * * ? *" # Run at 00:00 am (UTC) every day

  input = [
    {
      source = jsondecode(data.http.input.response_body).output.location
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
