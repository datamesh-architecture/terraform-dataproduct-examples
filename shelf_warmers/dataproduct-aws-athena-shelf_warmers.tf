module shelf_warmers {
  source = "git@github.com:datamesh-architecture/terraform-datamesh-dataproduct-aws-athena.git"

  aws        = var.aws

  domain   = "fulfillment"
  name     = "shelf_warmers"
  schedule = "0 0 * * ? *" # Run at 00:00 am (UTC) every day

  input = [
    {
      source = "<data_product_endpoint>"
    }
  ]

  transform = {
    query = "sql/transform.sql"
  }

  output = {
    format   = "PARQUET"
  }
}
