# AWS modules

Standalone Terraform modules for **Amazon Web Services**. Each module covers one product or service. Dependencies (VPC, IAM, etc.) are wired by the caller. No `module { source = "..." }` inside modules. Naming follows the same style as **GCP** (kebab-case, product-oriented).

**Terraform version:** Modules are version-agnostic. Your root config sets Terraform and provider versions.

---

## What’s here (by use)

| Module | What it is | What it’s for |
|--------|------------|----------------|
| **vpc** | VPC, public/private subnets, IGW, NAT gateway(s) | Networking for all AWS resources; base for EKS, EC2, RDS, Lambda in VPC |
| **eks** | EKS cluster, managed node groups, addons, cluster/node IAM roles, OIDC for IRSA | Managed Kubernetes; pod IAM via IRSA (like GKE Workload Identity) |
| **s3-bucket** | S3 bucket with optional versioning | Object storage, static assets, data lake, Lambda layers |
| **ec2-instance** | Single EC2 instance | VMs, bastions, single-node apps |
| **rds** | RDS DB instance + DB subnet group | Managed relational DB (MySQL, Postgres, etc.) |
| **iam** | IAM role (service principal + policy attachments) | Roles for Lambda, ECS, EC2, or cross-account access |
| **lambda** | Lambda function (zip or S3) | Serverless functions, event-driven and HTTP |
| **kms** | KMS key + optional alias | Encryption keys for S3, RDS, Secrets Manager, etc. |
| **secrets-manager** | Secrets Manager secret + optional version | App secrets, DB credentials, API keys |
| **route53** | Route 53 public hosted zone | DNS for public domains |
| **alb** | Application Load Balancer | HTTP(S) load balancing in front of ECS, EC2, Lambda |
| **ecr** | ECR private repository | Container images for EKS, ECS, Lambda |
| **sqs** | SQS queue | Message queues, decoupling, async processing |
| **sns** | SNS topic | Pub/sub, notifications, fan-out to SQS/Lambda |
| **dynamodb-table** | DynamoDB table | NoSQL key-value/store; serverless DB |
| **cloudwatch** | CloudWatch log group | Centralized logs; retention and optional KMS |
| **eventbridge** | EventBridge rule + optional target | Event routing, scheduled rules, cross-service events |
| **emr** | EMR cluster (minimal) | Big data / Spark on AWS |
| **security-group** | Security group with ingress/egress rules | EC2, RDS, ALB, Lambda VPC, EKS nodes, ElastiCache |
| **ssm-parameter** | SSM Parameter Store parameter (String / SecureString) | Config and secrets; complements secrets-manager |
| **acm** | ACM certificate (public) | TLS for ALB, CloudFront, API Gateway; caller does DNS validation |
| **elasticache** | ElastiCache Redis replication group (+ optional subnet group) | Caching, session store, pub/sub |
| **autoscaling** | Auto Scaling group | Scale EC2 behind ALB/NLB; use with launch template from caller |
| **apigateway-v2** | API Gateway v2 HTTP API (+ optional integration & stage) | Serverless APIs in front of Lambda or HTTP |
| **redshift** | Redshift cluster + optional subnet group | Data warehouse / analytics |
| **step-functions** | Step Functions state machine | Workflow orchestration, ETL, event-driven pipelines |
| **ecs** | ECS cluster + optional Fargate/EC2 service | Containers without Kubernetes; task definition from caller |
| **msk** | MSK (Managed Kafka) cluster | Event streaming |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and its own `README.md`. Code is standalone (no internal module calls).

---

## How to use these modules

- **Start with networking:** Create a **vpc** first; pass `private_subnet_ids` / `public_subnet_ids` to **eks**, **rds**, **ec2-instance**, or **lambda** (when using VPC).
- **Containers:** Use **ecr** for images; use **eks** for Kubernetes or add **ecs** later for Fargate. Wire **alb** in front of EKS Ingress or ECS services.
- **Apps and APIs:** **lambda** + **apigateway-v2** for serverless APIs; **ec2-instance** for VMs; **rds** for DB; **secrets-manager** or **ssm-parameter** for config; **acm** for TLS certs.
- **Data and events:** **s3-bucket** for storage; **dynamodb-table** for serverless DB; **sqs** + **sns** or **eventbridge** for queues and events; **emr** for Spark/batch; **redshift** for warehouse; **msk** for Kafka; **step-functions** for workflows.
- **Identity and security:** Create **security-group** and **iam** roles; pass to **lambda**, **ec2-instance**, **eks**, **rds**, **elasticache**, **ecs**, **msk**; use **kms** for encryption; **route53** for DNS.

For cross-cloud comparison (GCP ↔ AWS ↔ Azure), see the main [README](../README.md#cross-cloud-counterparts).

---

## Usage

Reference by path (local or Git). Example — VPC and EKS:

```hcl
module "vpc" {
  source = "./aws/vpc"

  name            = "my-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
  enable_nat_gateway = true
}

module "eks" {
  source       = "./aws/eks"
  cluster_name = "my-eks"
  subnet_ids   = module.vpc.private_subnet_ids
  node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 10
      desired_size   = 2
    }
  }
}
```

---

## EKS and GKE (identity / RBAC)

**EKS** is the AWS counterpart to **GKE** (gcp/kubernetes-engine). For pod → cloud IAM and API access:

- **GKE:** Workload Identity (`workload_identity_config` in the cluster).
- **AWS:** The **eks** module creates an OIDC provider for **IRSA** by default (`enable_irsa = true`). Use outputs `oidc_issuer_url` and `oidc_provider_arn` to create IAM roles that pods assume via service account. **access_config.authentication_mode** controls who can call the cluster API (e.g. `API` = IAM access entries).

---

## Other services

For services not in this set (e.g. **Cognito**, **Glue**, **SageMaker**, **Kinesis**, **WAF**), use the [Terraform Registry](https://registry.terraform.io/search/modules?provider=aws) or minimal custom modules.
