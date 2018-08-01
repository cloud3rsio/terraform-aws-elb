# Simple VPC

Creates set of VPC resources.

## Usage

```hcl
module "elb" {
  source = "github.com/cloud3rsio/terraform-aws-elb"

  name            = "simple-elb"
  subnets         = ["subnet-00000000", "subnet-11111111", "subnet-22222222"]
  security_groups = ["sg-00000000"]

  tags = {
    Environment = "development"
  }
}
```

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
