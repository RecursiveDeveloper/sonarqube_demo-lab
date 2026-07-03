## 🚀 About Me
I'm a junior DevOps engineer with some expertise in BackEnd development using Java and Node.js; scripting skills with Python, Bash and JavaScript; besides CI/CD and cloud knowledge of AWS and Azure DevOps tools ...

<p align="center">
<img src="https://c4.wallpaperflare.com/wallpaper/694/164/1000/digital-art-animals-eagle-bird-of-prey-birds-hd-wallpaper-preview.jpg" alt="Logo" width="400" height="230">
</p>

![linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![javascript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![nodejs](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)
![mysql](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=Jenkins&logoColor=white)
![aws](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![azuredevops](https://img.shields.io/badge/Azure_DevOps-0078D7?style=for-the-badge&logo=azure-devops&logoColor=white)

## 🔗 Portfolio
[![portfolio](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/RecursiveDeveloper)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jhoan-jesus-ortiz-sandoval-a66152198/)

# SonarQube Demo Lab

SonarQube is a self-managed, automatic code review tool that helps you deliver clean code by detecting issues across 30+ programming languages and integrating into your CI/CD pipeline. [See more](https://docs.sonarqube.org/latest/)

This lab is aimed at providing various ways to deploy a SonarQube server: locally using Docker containers, manually provisioning an AWS EC2 instance using Terraform CLI, or fully automated through a GitHub Actions pipeline.

## Tech Stack

- **Code Quality:** SonarQube
- **Containerization:** Docker
- **IaC:** Terraform
- **Cloud Provider:** AWS (EC2, VPC, S3)
- **CI/CD:** GitHub Actions

## Project Structure

```
sonarqube_demo-lab/
├── .github/
│   ├── actions/
│   │   └── setup/
│   │       └── action.yml          # Composite action: AWS CLI, credentials, Terraform setup
│   └── workflows/
│       └── main.yml                # GitHub Actions workflow (deploy / destroy)
├── iac/
│   ├── modules/
│   │   ├── ec2/                    # EC2 instance module (t2.medium)
│   │   └── vpc/                    # VPC and public subnet module
│   ├── scripts/
│   │   └── user_data.sh            # EC2 bootstrap script for SonarQube
│   ├── main.tf                     # Root module
│   ├── variables.tf                # Input variables (AMI, instance type)
│   ├── outputs.tf                  # Output values
│   └── provider.tf                 # AWS provider + S3 remote backend
├── local_deploy/
│   ├── start_Sonarq.sh             # Start SonarQube container with named volumes
│   └── stop_Sonarq.sh              # Stop and clean up container, image, and volumes
└── README.md
```

---

## Deployment

### 1. Local deployment using Docker containers

Check if Docker is installed on your OS. Otherwise, follow the documentation for your platform. [Install Docker Engine](https://docs.docker.com/engine/install/)

**Start SonarQube** — runs the container with three named volumes for data persistence:

```bash
bash local_deploy/start_Sonarq.sh
```

Once the instance is up, log in at [http://localhost:9000](http://localhost:9000) with the default System Administrator credentials:

```text
login:    admin
password: admin
```

[See more about first-time setup](https://docs.sonarqube.org/latest/try-out-sonarqube/)

**Stop SonarQube** — removes the container, image, and all associated volumes:

```bash
bash local_deploy/stop_Sonarq.sh
```

---

### 2. Manual deployment using Terraform CLI

Provisions a SonarQube server on AWS (EC2 `t2.medium` inside a dedicated VPC). State is stored remotely in an S3 bucket.

#### Prerequisites

1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and configure your credentials:
   ```bash
   aws configure
   ```
2. Install [Terraform CLI](https://developer.hashicorp.com/terraform/install) (version compatible with `~> 6.0` AWS provider).
3. Make sure the S3 bucket for the remote backend already exists in your AWS account.
4. Open `iac/provider.tf` and replace the placeholder values with your own:
   ```hcl
   bucket = "AWS_REGION"      # replace with your S3 bucket name
   region = "S3_BUCKET_NAME"  # replace with your AWS region (e.g. us-east-1)
   ```

#### Deploy

```bash
cd iac
terraform init
terraform plan
terraform apply
```

#### Destroy

```bash
cd iac
terraform destroy
```

---

### 3. Automated deployment using GitHub Actions

The workflow defined in `.github/workflows/main.yml` automates the full deploy/destroy lifecycle against AWS using Terraform. It is triggered manually via `workflow_dispatch`. Push to `main` is currently disabled but can be enabled by uncommenting the `push` trigger block in `main.yml` if desired.

#### Required repository variables

The following must be set as **Actions variables** in the repository settings (`Settings → Secrets and variables → Actions → Variables`):

| Variable | Description |
|---|---|
| `AWS_REGION` | AWS region where resources will be provisioned (e.g. `us-east-1`) |
| `S3_BUCKET_NAME` | Name of the existing S3 bucket used for Terraform remote state |
| `TERRAFORM_VERSION` | Terraform version to use in the pipeline (e.g. `1.12.2`) |

#### Required repository secrets

The following must be set as **Actions secrets** in the repository settings (`Settings → Secrets and variables → Actions → Secrets`):

| Secret | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | AWS access key ID with permissions to create EC2, VPC, and S3 resources |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key |

#### Trigger manually

1. Go to **Actions** → **workflow to deploy a sonarqube server into aws**
2. Click **Run workflow**
3. Select the action: `deploy` or `destroy`

---

## Authors

- [@RecursiveDeveloper](https://github.com/RecursiveDeveloper)

## License

[MIT](https://choosealicense.com/licenses/mit/)