# Simple VPC

Creates set of ELB resources.

## Usage

```hcl
module "elb" {
  source = "github.com/cloud3rsio/terraform-aws-elb"

  name             = "simple-elb"
  vpc_id           = "vpc-0000000"
  subnets          = ["subnet-00000000", "subnet-11111111", "subnet-22222222"]
  target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:00000000:targetgroup/targetgroup-name/000000000000"

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
