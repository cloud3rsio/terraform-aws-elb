resource "aws_lb" "main" {
  count = "${var.create_elb ? 1 : 0}"

  name               = "${var.name}"
  internal           = "${var.internal}"
  load_balancer_type = "${var.load_balancer_type}"
  security_groups    = ["${aws_security_group.main.id}"]
  subnets            = ["${var.subnets}"]

  enable_deletion_protection       = "${var.enable_deletion_protection}"
  idle_timeout                     = "${var.idle_timeout}"
  ip_address_type                  = "${var.ip_address_type}"
  enable_cross_zone_load_balancing = "${var.enable_cross_zone_load_balancing}"

  access_logs {
    bucket  = "${var.create_logging_bucket ? aws_s3_bucket.main.id : var.access_logs_bucket}"
    prefix  = "${var.access_logs_prefix}"
    enabled = "${var.enabled_access_logs}"
  }

  tags = "${merge(var.tags,map("Name", format("%s", var.name)), map("ModuleSource", var.module_source))}"
}

resource "aws_security_group" "main" {
  count = "${var.create_elb ? 1 : 0}"

  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags,map("Name", format("%s", var.name)), map("ModuleSource", var.module_source))}"
}

data "aws_elb_service_account" "main" {}

data "aws_iam_policy_document" "main" {
  statement = {
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.name}/*"]

    principals = {
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
      type        = "AWS"
    }
  }
}

resource "aws_s3_bucket" "main" {
  count = "${var.create_logging_bucket ? 1 : 0}"

  bucket_prefix = "${var.name}"
  acl           = "private"
  policy        = "${data.aws_iam_policy_document.main.json}"
  force_destroy = "${var.logging_bucket_force_destroy}"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "main"
    prefix  = "${var.logging_bucket_lifecycle_rule_prefix}"
    enabled = "${var.logging_bucket_lifecycle_rule_enabled}"

    expiration {
      days = "${var.logging_bucket_lifecycle_rule_expiration_days}"
    }

    noncurrent_version_expiration {
      days = "${var.logging_bucket_lifecycle_rule_noncurrent_version_expiration_days}"
    }
  }

  tags = "${merge(var.tags,map("Name", format("%s", var.name)), map("ModuleSource", var.module_source))}"
}

resource "aws_acm_certificate" "main" {
  count = "${var.enabled_https ? 1 : 0}"

  domain_name               = "${var.acm_domain_name}"
  subject_alternative_names = "${var.acm_subject_alternative_names}"
  validation_method         = "${var.acm_validation_method}"

  tags = "${merge(var.tags,map("Name", format("%s", var.name)), map("ModuleSource", var.module_source))}"
}

resource "aws_acm_certificate_validation" "main" {
  count = "${var.enabled_https ? 1 : 0}"

  certificate_arn = "${aws_acm_certificate.main.arn}"
}

resource "aws_lb_listener" "http" {
  count = "${var.create_elb ? 1 : 0}"

  load_balancer_arn = "${aws_lb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "https" {
  count = "${var.create_elb && var.enabled_https ? 1 : 0}"

  load_balancer_arn = "${aws_lb.main.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_acm_certificate_validation.main.certificate_arn}"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}
