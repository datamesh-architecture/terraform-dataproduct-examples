output "kafka" {
  value = {
    environment = {
      id             = confluent_environment.environment.id
    }
    cluster = {
      id             = confluent_kafka_cluster.kafka_cluster.id
      api_version    = confluent_kafka_cluster.kafka_cluster.api_version
      kind           = confluent_kafka_cluster.kafka_cluster.kind
      rest_endpoint  = confluent_kafka_cluster.kafka_cluster.rest_endpoint
    }
    credentials = {
      api_key_id     = confluent_api_key.app-manager-kafka-api-key.id
      api_key_secret = confluent_api_key.app-manager-kafka-api-key.secret
    }
  }
}
