# jborg-terraform-backend

This Terraform project will create a S3 bucket for storing state files and a
DynamoDB table for state locking.

## Usage

1. Copy the `example.tfvars` file and edit it.

2. Run the follow commands in the repository directory:

```bash
# Set the name of the environment file you created
TFVarsFile=MyTfvarsFile.tfvars

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan -out=planfile -var-file=$TFVarsFile

# Apply the changes
terraform apply planfile
```

3. To use the new backend, add the following Terraform settings to your
project:

```hcl
# S3 Backend Settings
terraform {
  required_version = ">= 0.9.0"  # Minimum version required for S3/DynamoDB support

  backend "s3" {
    profile        = "MyAwsCliProfile"
    encrypt        = "true"
    region         = "us-west-2"
    bucket         = "MyBucketName"
    key            = "MyProject/terraform.tfstate"
    dynamodb_table = "MyTableName"
  }
}
```
