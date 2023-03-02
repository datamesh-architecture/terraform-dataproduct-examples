module "confluent_kafka" {
  source = "./confluent_kafka"

  topics = [ "stock" ]
}

module "kafka_to_s3" {
  source    = "git@github.com:datamesh-architecture/terraform-dataproduct-confluent-kafka-to-aws-s3.git"

  aws       = var.aws
  confluent = var.confluent
  kafka     = module.confluent_kafka.kafka

  domain = "fulfillment"
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
    grant_access  = [ "<aws_account_id>" ]
  }
}
