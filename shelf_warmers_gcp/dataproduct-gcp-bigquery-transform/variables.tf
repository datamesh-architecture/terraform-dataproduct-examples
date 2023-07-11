variable "gcp" {
  type = object({
    credentials = string
    project     = string
    region      = string
  })
  sensitive   = true
  description = "Google Cloud related information and credentials"
}

variable "source_table" {
  type        = string
  description = "The BigQuery source table for the aggregation"
}
