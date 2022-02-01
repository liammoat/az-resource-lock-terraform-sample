variable "prefix" {
  type    = string
  default = "lm-lockdemo"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "env" {
  type = string
}

variable "enable_locks" {
  type    = bool
}
