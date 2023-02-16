module "kafka_to_s3" {
  source    = "git@github.com:datamesh-architecture/terraform-datamesh-dataproduct-confluent-kafka-to-aws-s3.git"

  aws       = var.aws
  confluent = var.confluent

  kafka     = {
    environment = {
      id = confluent_environment.environment.id
    }
    cluster = {
      id            = confluent_kafka_cluster.kafka_cluster.id
      api_version   = confluent_kafka_cluster.kafka_cluster.api_version
      kind          = confluent_kafka_cluster.kafka_cluster.kind
      rest_endpoint = confluent_kafka_cluster.kafka_cluster.rest_endpoint
    }
  }
  kafka_api_credentials = {
    api_key_id      = confluent_api_key.app-manager-kafka-api-key.id
    api_key_secret  = confluent_api_key.app-manager-kafka-api-key.secret
  }

  aws_athena = {
    workgroup_name = aws_athena_workgroup.aws_athena_workgroup.name
    catalog_name   = aws_athena_data_catalog.aws_athena_data_catalog.name
  }
  aws_glue = {
    database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
    catalog_id    = aws_glue_catalog_database.aws_glue_catalog_database.catalog_id
  }

  domain = "fulfillment_raw"
  name = "stock_updated"
  input = [
    {
      topic      = "stock"
      format     = "JSON"
      table_name = "stock_updated"
      schema     = "schema/stock_updated.schema.json"
    }
  ]
  output = {
    grant_access = [ "528115139298" ]
  }
}
