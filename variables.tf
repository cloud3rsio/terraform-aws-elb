variable "module_source" {
  default = "github.com/cloud3rsio/terraform-aws-elb"
}

variable "create_elb" {
  default = true
}

variable "name" {
  default = "terraform-aws-elb"
}

variable "internal" {
  default = false
}

variable "load_balancer_type" {
  default = "application"
}

variable "subnets" {
  default = []
}

variable "enable_deletion_protection" {
  default = false
}

variable "ip_address_type" {
  default = "ipv4"
}

variable "enabled_access_logs" {
  default = true
}

variable "access_logs_bucket" {
  default = ""
}

variable "access_logs_prefix" {
  default = ""
}

variable "idle_timeout" {
  default = 60
}

variable "enable_cross_zone_load_balancing" {
  default = true
}

variable "tags" {
  default = {}
}

variable "create_logging_bucket" {
  default = true
}

variable "logging_bucket_force_destroy" {
  default = true
}

variable "logging_bucket_lifecycle_rule_prefix" {
  default = ""
}

variable "logging_bucket_lifecycle_rule_enabled" {
  default = true
}

variable "logging_bucket_lifecycle_rule_expiration_days" {
  default = 180
}

variable "logging_bucket_lifecycle_rule_noncurrent_version_expiration_days" {
  default = 180
}

variable "enabled_https" {
  default = false
}

variable "acm_domain_name" {
  default = ""
}

variable "acm_subject_alternative_names" {
  default = []
}

variable "acm_validation_method" {
  default = "DNS"
}

variable "target_group_arn" {
  default = ""
}

variable "vpc_id" {
  default = ""
}
