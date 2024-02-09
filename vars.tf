variable "default_tags" {
  type = map(string)
  default = {
    "username" = "maarons"
  }
  description = "This is a resource in my terraform testing environment"
}
variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets in VPC"
  default     = 2
}
variable "private_subnet_count" {
  type        = number
  description = "number of private subnet"
  default     = 2
}

variable "sg_db_ingress" {
  type = map(object({
    port     = number
    protocol = string
    self     = bool
  }))
  default = {
    "postgresql" = {
      port     = 5432
      protocol = "tcp"
      self     = true
    }
  }
}
variable "sg_db_egress" {
  type = map(object({
    port     = number
    protocol = string
    self     = bool
  }))
  default = {
    "all" = {
      port     = 0
      protocol = "-1"
      self     = true
    }
  }
}

variable "db_credentials" {
  type      = map(any)
  sensitive = true
  default = {
    username = "username"
    password = "password"
  }
}