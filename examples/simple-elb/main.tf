provider "aws" {
  region = "ap-northeast-1"
}

module "elb" {
  source = "../../"

  name             = "simple-elb"
  vpc_id           = "vpc-7925711e"
  subnets          = ["subnet-5252421b", "subnet-f0f9baab", "subnet-066f742e"]
  target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:380421963481:targetgroup/simple-elb-targetgroup/6997313e3f460e34"

  enabled_https   = true
  acm_domain_name = "tf-test.tmp.cloud3rs.io"

  tags = {
    Environment = "development"
  }
}

output "test" {
  value = "${module.elb.acm_domain_validation_options}"
}
