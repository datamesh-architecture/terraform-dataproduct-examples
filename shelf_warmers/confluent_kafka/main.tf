resource "confluent_environment" "environment" {
  display_name = var.environment_name
}

resource "confluent_kafka_cluster" "kafka_cluster" {
  display_name = var.cluster_name
  availability = var.availability
  cloud        = var.cloud
  region       = var.region

  standard {}

  environment {
    id = confluent_environment.environment.id
  }
}

resource "confluent_service_account" "app-manager" {
  display_name = "${var.cluster_name}-app-manager"
  description  = "Service account to manage Kafka cluster"
}

resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.kafka_cluster.rbac_crn
}

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "${var.cluster_name}-app-manager-kafka-api-key"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }
  managed_resource {
    id          = confluent_kafka_cluster.kafka_cluster.id
    api_version = confluent_kafka_cluster.kafka_cluster.api_version
    kind        = confluent_kafka_cluster.kafka_cluster.kind

    environment {
      id = confluent_environment.environment.id
    }
  }
  depends_on = [
    confluent_role_binding.app-manager-kafka-cluster-admin
  ]
}

resource "confluent_kafka_topic" "confluent_kafka_topic" {
  count = length(var.topics)

  kafka_cluster {
    id = confluent_kafka_cluster.kafka_cluster.id
  }
  topic_name    = var.topics[count.index]
  rest_endpoint = confluent_kafka_cluster.kafka_cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }
}
