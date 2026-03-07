# Terraform AWS Infrastructure

I built this project to learn how to provision cloud infrastructure using Terraform and automate deployments through GitHub Actions. It deploys a basic but real AWS setup — VPC, EC2, and RDS — the kind of foundation you'd see in an actual backend environment.

This is part of my journey into Cloud and DevOps engineering.

---

## What This Deploys

A full AWS environment in `ap-southeast-1` (Singapore):

```
Internet
    │
    ▼
Internet Gateway
    │
    ▼
Public Subnet (10.0.1.0/24) — ap-southeast-1a
    └── EC2 Instance (web-server)

Private Subnet 1 (10.0.2.0/24) — ap-southeast-1b ──┐
Private Subnet 2 (10.0.3.0/24) — ap-southeast-1c ──┴── RDS MySQL
```

- **VPC** with public and private subnets across multiple availability zones
- **EC2** instance in the public subnet (Amazon Linux 2)
- **RDS MySQL** in private subnets (multi-AZ subnet group)
- **Security groups** — EC2 allows ports 22 and 80, RDS only allows 3306 from within the VPC
- **S3 + DynamoDB** for remote Terraform state and state locking

---

## How the Pipeline Works

Every push to `main` triggers the GitHub Actions workflow:

```
git push → terraform fmt check → terraform validate → terraform plan → terraform apply
```

No manual steps. If any stage fails, the pipeline stops and nothing gets deployed.

The destroy workflow is intentionally manual — you have to click a button in GitHub Actions to run it. I did this so nothing gets accidentally deleted.

---

## Project Structure

```
terraform-aws-infra/
├── .github/
│   └── workflows/
│       ├── terraform.yml       # runs on every push to main
│       └── destroy.yml         # manual trigger only
├── modules/
│   ├── vpc/                    # networking — subnets, IGW, route tables, security groups
│   ├── ec2/                    # web server instance
│   └── rds/                    # managed MySQL database
├── main.tf                     # connects all modules together
├── variables.tf                # all input variables with defaults
├── outputs.tf                  # exposes resource IDs after apply
├── providers.tf                # AWS provider + region
├── backend.tf                  # remote state in S3
├── version.tf                  # Terraform version lock
└── terraform.tfvars.example    # template for local setup
```

---

## Running This Locally

**Requirements:**
- Terraform >= 1.5.0
- AWS CLI with credentials configured
- An AWS account with permissions for VPC, EC2, RDS, S3, DynamoDB

```bash
# Clone the repo
git clone https://github.com/Tettano/terraform-aws-infra.git
cd terraform-aws-infra

# Set up your variables
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and add your DB username and password

# Deploy
terraform init
terraform plan
terraform apply
```

---

## Setting Up the CI/CD Pipeline

You'll need to add these secrets to your GitHub repo under **Settings → Secrets and variables → Actions**:

| Secret | What it's for |
|--------|--------------|
| `AWS_ACCESS_KEY_ID` | AWS access key |
| `AWS_SECRET_ACCESS_KEY` | AWS secret key |
| `TF_VAR_username` | RDS database username |
| `TF_VAR_password` | RDS database password |

Once those are set, pushing to `main` will automatically deploy.

---

## Destroying the Infrastructure

When you're done, make sure to clean up to avoid AWS charges.

```bash
# Locally
terraform destroy
```

Or go to **GitHub Actions → Terraform Destroy → Run workflow** to trigger it from the pipeline.

---

## Things I Learned Building This

Honestly this project broke in a lot of ways before it worked, and that's where most of the learning happened:

- Terraform modules are black boxes — if you need a value from another module, you have to explicitly expose it through `output.tf`. I kept getting "unsupported attribute" errors until I understood this properly.
- Always run `terraform fmt -recursive` before pushing. The CI pipeline checks formatting and will fail if your code isn't clean.
- Add `-input=false` to `terraform plan` and `apply` in CI/CD. Without it, Terraform silently waits for user input and the pipeline just hangs for hours.
- Never force-cancel a running Terraform job. It leaves a stale lock in DynamoDB and your next run will fail with a lock error. Use `terraform force-unlock <ID>` to fix it.
- RDS subnet groups need subnets in at least 2 availability zones. AWS enforces this for high availability and won't let you create one otherwise.
- AMI IDs are region-specific. The same AMI ID from one region won't exist in another.

---

## Author

**Shawn Mark Retes**
Philippines 🇵🇭 — currently learning Cloud and DevOps
GitHub: [@Tettano](https://github.com/Tettano)
