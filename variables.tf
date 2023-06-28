variable "prefix" {
  type    = string
  default = "auto_tags"
}

variable "tags_to_apply" {
  type = list(object({
    Key   = string
    Value = string
  }))
}