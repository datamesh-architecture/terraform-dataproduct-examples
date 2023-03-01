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
  default = [ "stock" ]
}

variable "availability" {
  type = string
  default = "SINGLE_ZONE"
}

variable "cloud" {
  type = string
  default = "AWS"
}

variable "region" {
  type = string
  default ="eu-central-1"
}
