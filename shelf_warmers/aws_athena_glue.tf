variable "aws_athena_workgroup_name" {
  type = string
  default = "fulfillment"
}

variable "aws_athena_data_catalog_name" {
  type = string
  default = "fulfillment"
}

variable "aws_glue_catalog_database_name" {
  type = string
  default = "fulfillment"
}

resource "aws_athena_workgroup" "aws_athena_workgroup" {
  name          = var.aws_athena_workgroup_name
  force_destroy = true

  configuration {
    enforce_workgroup_configuration    = false
    publish_cloudwatch_metrics_enabled = true
  }
}

resource "aws_athena_data_catalog" "aws_athena_data_catalog" {
  description = "Glue based data catalog from data domain ${var.aws_athena_data_catalog_name}"
  name        = var.aws_athena_data_catalog_name
  type        = "GLUE"
  parameters  = {
    "catalog-id" = aws_glue_catalog_database.aws_glue_catalog_database.catalog_id
  }
}

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = var.aws_glue_catalog_database_name
}
