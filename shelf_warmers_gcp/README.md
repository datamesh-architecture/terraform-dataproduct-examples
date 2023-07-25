# Example "Shelf warmers"

## Context

Shelf warmers are articles in commerce that have been in stock for 3 months but have not been sold.

## Structure

The shelf warmer example uses two Terraform modules:
* [Module Confluent Kafka to GCP BigQuery](https://github.com/datamesh-architecture/terraform-dataproduct-confluent-kafka-to-gcp-bigquery)
* [Module GCP BigQuery Transform](https://github.com/datamesh-architecture/terraform-dataproduct-gcp-bigquery-transform)

## Architecture

![Architecture of the Example](https://raw.githubusercontent.com/datamesh-architecture/datamesh-architecture.com/main/images/terraform-datamesh-dataproduct-gcp.png)

### `GET /datamesh/fulfillment/stock`

```json
{
  "domain": "fulfillment",
  "name": "stock",
  "output": {
    "locations": [
      "https://bigquery.googleapis.com/bigquery/v2/projects/<project>/datasets/source/tables/stock"
    ]
  }
}
```

### `GET /datamesh/fulfillment/shelf_warmers`

TBD

```json
{}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | >= 1.35 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | >= 1.35 |
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.59.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Usage

### Setup first data product "dataproduct-confluent-kafka-to-gcp-bigquery"
1. `cd dataproduct-confluent-kafka-to-gcp-bigquery`
2. `cp .terraform.tfvars.template .terraform.tfvars` and enter GCP project info, add the path to the [credentials file of your service account](https://developers.google.com/workspace/guides/create-credentials#create_credentials_for_a_service_account) and Confluent credentials
3. (optional) Add principals to `data_access` and `discovery_access` in [main.tf](https://github.com/datamesh-architecture/terraform-dataproduct-examples/blob/main/shelf_warmers_gcp/dataproduct-confluent-kafka-to-gcp-bigquery/main.tf#L23). Check (https://cloud.google.com/iam/docs/overview#concepts_related_identity) for more information about IAM management in GCP.
4. `terraform init`
5. `terraform apply`
6. Enter `yes` and press ENTER

### Setup second data product "dataproduct-gcp-bigquery-transform"
1. `cd dataproduct-gcp-bigquery-transform`
2. `cp .terraform.tfvars.template .terraform.tfvars` and enter GCP project info, add the path to the [credentials file of your service account](https://developers.google.com/workspace/guides/create-credentials#create_credentials_for_a_service_account) and Confluent credentials
3. Adapt `shelf_warmers.sql`
4. `terraform init`
5. `terraform apply`
6. Enter `yes` and press ENTER

### Discovery
You can now call the discovery endpoint:
```shell
curl <discovery_endpoint>
```

### Create and explore example data
When you put example datasets in your kafka (https://confluent.cloud/environments/env-<your_environment>/clusters/<your_cluster>/topics/stock/message-viewer), you should be able to find them in the generated table (https://console.cloud.google.com/bigquery?project=<your_project>&ws=!1m5!1m4!4m3!1s<your_project>!2ssource!3sstock).

#### Example Message
```json
{
"location": "store",
"available": 87,
"updated_at": 1680268473,
"sku": "xxx"
}
```

### Setup second data product

TBD
