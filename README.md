# AWS ELB Terraform module

Terraform module which creates ELB resources on AWS.

These types of resources are supported:

* [ELB](https://www.terraform.io/docs/providers/aws/r/elb.html)
* [ELB Listener]()
* [S3](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html)
* [ACM]()

## Usage

```hcl
module "elb" {
  source = "github.com/cloud3rsio/terraform-aws-elb"

  name            = "simple-elb"
  subnets         = ["subnet-00000000", "subnet-11111111", "subnet-22222222"]
  security_groups = ["sg-00000000"]

  target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:00000000:targetgroup/targetgroup-name/000000000000"

  enabled_https   = true
  acm_domain_name = "tf-test.tmp.cloud3rs.io"

  tags = {
    Environment = "development"
  }
}
```

## Examples

* [Simple ELB](./examples/simple-elb/)

## License

Apache 2 Licensed. See LICENSE for full details.
