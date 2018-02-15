# terraform-aws-default-tags

Don't forget to add tags to the `lifecycle` `ignore_changes` since the usage of `timestamp()` will result in changes every time.

## Example

``` HCL
module "tags" {
  source = "github.com/jasisk/terraform-aws-default-tags?ref=0.0.1"
  # `extra_tags` is optional
  extra_tags = {
    BonusTag = "extra stuff"
  }
}

resource "aws_instance" "machine" {
  tags = "${module.tags.map}"
  # ... or ...
  tags = "${merge(module.tags.map, map("ResourceSpecificTag", "value for it"))}"

  # ... always ignore_changes to the dynamic tags!
  lifecycle {
    ignore_changes = ["tags.LastModifiedBy", "tags.LastModifiedTime"]
  }
}
```
