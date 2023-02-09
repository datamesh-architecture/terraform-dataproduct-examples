module shelf_warmers {
  source = "git@github.com:datamesh-architecture/terraform-datamesh-dataproduct-aws-athena.git"

  aws        = var.aws

  domain   = "fulfillment"
  name     = "shelf_warmers"
  schedule = "0 0 * * ? *" # Run at 00:00 am (UTC) every day

  input = [
    {
      source = "https://ykkep4kh79.execute-api.eu-central-1.amazonaws.com/prod/"
    }
  ]

  transform = {
    query = "sql/transform.sql"
  }

  output = {
    format   = "PARQUET"
    location = "shelf_warmers"
  }
}
