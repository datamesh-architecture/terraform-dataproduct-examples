variable "gcp" {
  type = object({
    credentials = string
    project     = string
    region      = string
    zone        = string
  })
  sensitive   = true
  description = "Google Cloud related information and credentials"
}

variable "confluent" {
  type = object({
    cloud_api_key    = string
    cloud_api_secret = string
  })
  sensitive   = true
  description = "Confluent (Cloud) related credentials"
}
