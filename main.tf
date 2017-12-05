provider "aws" {}

variable "extra_tags" {
  default = {}
}

data "aws_caller_identity" "current" {}

locals {
  computed_tags = {
    LastModifiedTime = "${timestamp()}"
    LastModifiedBy = "${data.aws_caller_identity.current.arn}"
  }
  merged_tags = "${merge(local.computed_tags, var.extra_tags)}"
}

output "map" {
  value = "${local.merged_tags}"
}

output "ignore_list" {
  value = ["${keys(local.merged_tags)}"]
}
