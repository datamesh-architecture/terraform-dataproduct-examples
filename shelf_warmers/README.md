# Example "Shelf warmers"

## Context

Shelf warmers are articles in commerce that have been in stock for 3 months but have not been sold.

## Structure

The shelf warmer example uses two Terraform modules:
* [Module Confluent Kafka to AWS S3](https://github.com/datamesh-architecture/terraform-dataproduct-confluent-kafka-to-aws-s3)
* [Module AWS Athena](https://github.com/datamesh-architecture/terraform-dataproduct-aws-athena)

## Architecture

![Architecture](https://www.datamesh-architecture.com/images/terraform-datamesh-dataproduct.png.webp)

## Requirements

| Name                                                                      | Version    |
|---------------------------------------------------------------------------|------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.7   |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 4.56    |
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | >= 1.34    |

## Providers

| Name                                                                | Version   |
|---------------------------------------------------------------------|-----------|
| <a name="provider_aws"></a> [aws](#provider\_aws)                   | >= 4.56   |
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | >= 1.34   |

## Usage

### Setup first data product "dataproduct-confluent-kafka-to-aws-s3"
1. `cd dataproduct-confluent-kafka-to-aws-s3`
2. `cp .terraform.tfvars.template .terraform.tfvars` and enter AWS and Confluent credentials
3. Replace `<aws_account_id>` in `main.tf`
4. `terraform apply`
5. Enter `yes` and press ENTER

### Setup second data product "dataproduct-aws-athena-shelf_warmers"
1. `cd dataproduct-aws-athena-shelf_warmers`
2. `cp .terraform.tfvars.template .terraform.tfvars` and enter AWS credentials
3. Replace `<data_product_endpoint>` in `main.tf` with the endpoint provided by the first data product
4. `terraform apply`
5. Enter `yes` and press ENTER
