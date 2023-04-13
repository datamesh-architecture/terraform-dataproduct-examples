variable "environment_name" {
  type = string
  description = "(Display) name of the Kafka cluster environment"
  default = "datamesh-dataproducts"
}

variable "cluster_name" {
  type = string
  description = "(Display) name of the Kafka cluster"
  default = "datamesh-dataproducts"
}

variable "topics" {
  type = list(string)
  description = "List of Kafka topics which should be created"
}

variable "availability" {
  type = string
  default = "SINGLE_ZONE"
}

variable "cloud" {
  type = string
  default = "GCP"
}

variable "region" {
  type = string
  default ="europe-west1"
}
