module "confluent_kafka" {
  source = "./confluent_kafka"
  topics = ["stock"]
}


module "kafka_to_bigquery" {
  source  = "datamesh-architecture/dataproduct-confluent-kafka-to-gcp-bigquery/google"
  version = "0.1.1"

  gcp   = var.gcp
  kafka = module.confluent_kafka.kafka

  domain = "fulfillment"
  name   = "stock"
  input  = [
    {
      topic  = "stock"
      format = "JSON"
    }
  ]

  output = {
    data_access      = []
    discovery_access = ["allUsers"]
    tables           = [
      {
        id                = "stock"
        schema            = "schema/stock.bigquery.json"
        delete_on_destroy = true
      }
    ]
  }

  output_tables_time_partitioning = {
    "stock" = {
      type  = "DAY" # DAY, HOUR, MONTH, YEAR
      field = null  # optional
    }
  }
}
