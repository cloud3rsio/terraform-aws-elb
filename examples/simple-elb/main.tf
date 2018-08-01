provider "aws" {
  region = "ap-northeast-1"
}

module "elb" {
  source = "../../"

  name             = "simple-elb"
  subnets          = ["subnet-5252421b", "subnet-f0f9baab", "subnet-066f742e"]
  security_groups  = ["sg-741b0f0c"]
  target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:380421963481:targetgroup/simple-elb-targetgroup/196874e227b14e29"

  tags = {
    Environment = "development"
  }
}
