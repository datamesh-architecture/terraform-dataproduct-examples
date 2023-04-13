output "discovery_endpoint" {
  value       = module.kafka_to_bigquery.discovery_endpoint
  description = "The URI of the generated discovery endpoint"
}
