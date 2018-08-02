output "elb_id" {
  value = "${element(concat(aws_lb.main.*.id, list("")), 0)}"
}

output "elb_arn" {
  value = "${element(concat(aws_lb.main.*.arn, list("")), 0)}"
}

output "elb_arn_suffix" {
  value = "${element(concat(aws_lb.main.*.arn_suffix, list("")), 0)}"
}

output "elb_dns_name" {
  value = "${element(concat(aws_lb.main.*.dns_name, list("")), 0)}"
}

output "elb_zone_id" {
  value = "${element(concat(aws_lb.main.*.zone_id, list("")), 0)}"
}

output "s3_id" {
  value = "${element(concat(aws_s3_bucket.main.*.id, list("")), 0)}"
}

output "s3_arn" {
  value = "${element(concat(aws_s3_bucket.main.*.arn, list("")), 0)}"
}

output "s3_bucket_domain_name" {
  value = "${element(concat(aws_s3_bucket.main.*.bucket_domain_name, list("")), 0)}"
}

output "s3_bucket_regional_domain_name" {
  value = "${element(concat(aws_s3_bucket.main.*.bucket_regional_domain_name, list("")), 0)}"
}

output "s3_hosted_zone_id" {
  value = "${element(concat(aws_s3_bucket.main.*.hosted_zone_id, list("")), 0)}"
}

output "s3_region" {
  value = "${element(concat(aws_s3_bucket.main.*.region, list("")), 0)}"
}

output "acm_id" {
  value = "${element(concat(aws_acm_certificate.main.*.id, list("")), 0)}"
}

output "acm_arn" {
  value = "${element(concat(aws_acm_certificate.main.*.arn, list("")), 0)}"
}

output "acm_domain_name" {
  value = "${element(concat(aws_acm_certificate.main.*.domain_name, list("")), 0)}"
}

output "acm_domain_validation_options" {
  value = "${flatten(aws_acm_certificate.main.*.domain_validation_options)}"
}

output "elb_listener_http_arn" {
  value = "${element(concat(aws_lb_listener.http.*.arn, list("")), 0)}"
}

output "elb_listener_https_arn" {
  value = "${element(concat(aws_lb_listener.https.*.arn, list("")), 0)}"
}
