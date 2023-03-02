# Example "Shelf warmers"

## Context

You work for the online retailer Teusaras, which specializes in high-quality children's toys. Teusaras employs about 100 people in software development. The associated online store teusaras.com is an in-house development with which Teusaras wants to differentiate itself from its market competitors through a better user experience and intelligent services.

Here is a typical customer journey: Martin wants to buy a high-quality wooden sword with a metal handle for his daughter Carola for her knight's birthday party. On Google, Martin types in "sturdy toy sword," and clicks on Teusaras' ad, which is at the top. Martin lands on the product detail page for a wooden sword with a gold-plated handle, but at €139.99 it is too expensive for him. However, other wooden swords with different handles are recommended on the page. He clicks through and finds a sword suitable for his daughter for 59.99 €, and with the search function he quickly finds a matching shield for 39.99 €. Since both products are only available once, he adds them to his shopping cart, quickly enters his credit card information and clicks 'buy'. He then creates a customer account for tracking and registers for the newsletter. He receives his invoice by e-mail a few minutes later, and the package arrives the next day. The knight's children's birthday party is a complete success.

The ad is still online, even though the item is now sold out. There is always a complaint to customer support about this. The customer support writes an email to the purchasing department that the sold out article should be reordered and tells the marketing department that the ad should be paused until then. In Controlling, this order is part of the reporting for the target/actual comparison and the contribution margin calculation, which are sent weekly to C-Level Management.

The COO wants to know how big the problem of slow-moving items (a.k.a. shelf warmers) is. Shelf warmers are items that have been in stock for 3 months but have no issues (inventory reduction).

## Structure

The shelf warmer example uses two Terraform modules:
* [Module Confluent Kafka to AWS S3](https://github.com/datamesh-architecture/terraform-dataproduct-confluent-kafka-to-aws-s3)
* [Module AWS Athena](https://github.com/datamesh-architecture/terraform-dataproduct-aws-athena)

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
