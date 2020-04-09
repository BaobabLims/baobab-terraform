# BAOBAB AWS TERRAFORM

This simple script will:
- Make a copy of the Amazon Ubuntu 16.04 AMI
- Create a security group for SSH and Web (port 80) access
- Create an EC2 instance with 2 Cores, 8GB RAM, 8GB SSD

## How to use:

1. Download and install `terraform`.
2. Clone this repo
3. cd to repo, run `terraform init`
4. Set environment variables:
    ```
    export AWS_ACCESS_KEY_ID=<access key>
    export AWS_SECRET_ACCESS_KEY=<secret>
    ```
5. Add necessary public keys for access in `instance_data.sh`
6. Run `terraform apply`.

**NB: USES LONDON AWS ZONE**