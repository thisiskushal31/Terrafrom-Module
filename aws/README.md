# AWS modules

Standalone Terraform modules for **Amazon Web Services**. Each module manages one AWS product or service. You supply dependencies (VPC, IAM, subnets, etc.) from your root or other modules; nothing inside these modules calls another module.

**Terraform:** Set required_version and providers in your root; these modules do not pin versions.

---

## What's here (what each module does)

| Module | What it is | What it's for |
|--------|------------|----------------|
| **vpc** | VPC with public/private subnets, IGW, NAT gateway(s) | Base networking for EKS, EC2, RDS, Lambda, etc. |
| **eks** | EKS cluster, managed node groups, addons, cluster/node IAM roles, OIDC for IRSA | Managed Kubernetes; pods can assume IAM roles via IRSA |
| **s3-bucket** | S3 bucket with optional versioning | Object storage, static assets, data lakes, Lambda layers |
| **ec2-instance** | Single EC2 instance | VMs, bastions, single-node apps |
| **rds** | RDS DB instance and DB subnet group | Managed relational DB (MySQL, Postgres, etc.) |
| **iam** | IAM role with service principal and policy attachments | Roles for Lambda, ECS, EC2, cross-account |
| **lambda** | Lambda function (zip or S3) | Serverless functions, event-driven and HTTP |
| **kms** | KMS key and optional alias | Encryption for S3, RDS, Secrets Manager, etc. |
| **secrets-manager** | Secrets Manager secret and optional version | App secrets, DB credentials, API keys |
| **route53** | Route 53 public hosted zone | DNS for public domains |
| **alb** | Application Load Balancer | HTTP(S) load balancing for ECS, EC2, Lambda |
| **ecr** | ECR private repository | Container images for EKS, ECS, Lambda |
| **sqs** | SQS queue | Message queues, decoupling, async processing |
| **sns** | SNS topic | Pub/sub, notifications, fan-out to SQS/Lambda |
| **dynamodb-table** | DynamoDB table | NoSQL key-value store; serverless DB |
| **cloudwatch** | CloudWatch log group | Centralized logs; retention and optional KMS |
| **eventbridge** | EventBridge rule and optional target | Event routing, scheduled rules, cross-service events |
| **emr** | EMR cluster (minimal) | Big data / Spark on AWS |
| **security-group** | Security group with configurable ingress/egress rules | Firewall for EC2, RDS, ALB, Lambda VPC, EKS, ElastiCache |
| **ssm-parameter** | SSM Parameter Store parameter (String / SecureString) | Config and secrets; complements secrets-manager |
| **acm** | ACM certificate (public) | TLS for ALB, CloudFront, API Gateway; you handle DNS validation |
| **elasticache** | ElastiCache Redis replication group and optional subnet group | Managed Redis (counterpart to GCP Memorystore, Azure Cache for Redis) |
| **autoscaling** | Auto Scaling group | Scale EC2 behind ALB/NLB; use with a launch template from caller |
| **apigateway-v2** | API Gateway v2 HTTP API with optional integration and stage | Serverless APIs in front of Lambda or HTTP |
| **redshift** | Redshift cluster and optional subnet group | Data warehouse and analytics |
| **step-functions** | Step Functions state machine | Workflow orchestration, ETL, event-driven pipelines |
| **ecs** | ECS cluster and optional Fargate/EC2 service | Containers without Kubernetes; you supply task definition |
| **msk** | MSK (Managed Kafka) cluster | Event streaming |
| **sagemaker** | SageMaker notebook instance | ML development (Jupyter); Studio/endpoints via Registry |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and a per-module `README.md`. No internal `module { source = "..." }` calls.

---

## How to use these modules

- **Networking:** Create **vpc** first; pass `private_subnet_ids` / `public_subnet_ids` to **eks**, **rds**, **ec2-instance**, **lambda**, etc.
- **Containers:** **ecr** for images; **eks** for Kubernetes or **ecs** for Fargate; **alb** in front of EKS Ingress or ECS services.
- **Apps and APIs:** **lambda** + **apigateway-v2** for serverless APIs; **ec2-instance** for VMs; **rds** for DB; **secrets-manager** or **ssm-parameter** for config; **acm** for TLS.
- **Data and events:** **s3-bucket**, **dynamodb-table**, **sqs**, **sns**, **eventbridge**, **emr**, **redshift**, **msk**, **step-functions**.
- **Identity and security:** **iam** roles and **security-group**; pass to services as needed; **kms** for encryption; **route53** for DNS.
- **AI/ML:** **sagemaker** for notebook instances; for Studio, training, or inference endpoints use the Terraform Registry.

Cross-cloud mapping: [main README](../README.md#cross-cloud-counterparts).

---

## Usage example

```hcl
module "vpc" {
  source = "./aws/vpc"

  name             = "my-vpc"
  cidr             = "10.0.0.0/16"
  azs              = ["us-east-1a", "us-east-1b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]
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

**EKS and pod IAM:** The **eks** module creates an OIDC provider for IRSA by default (`enable_irsa = true`). Use outputs `oidc_issuer_url` and `oidc_provider_arn` to create IAM roles that pods assume via service account. `authentication_mode` controls who can call the cluster API (e.g. IAM access entries).

---

## Other AWS services

For services not in this set (e.g. Cognito, Glue, SageMaker Studio/endpoints, Kinesis, WAF, Bedrock), use the [Terraform Registry](https://registry.terraform.io/search/modules?provider=aws) or your own minimal modules.
