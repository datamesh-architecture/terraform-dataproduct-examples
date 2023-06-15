variable "aws" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
  sensitive = true
  description = "AWS related information and credentials"
}

variable "confluent" {
  type = object({
    cloud_api_key    = string
    cloud_api_secret = string
  })
  sensitive = true
  description = "Confluent (Cloud) related credentials"
}
