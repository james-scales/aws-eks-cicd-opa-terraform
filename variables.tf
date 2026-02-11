#------------Project------------#
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "sa-east-1"
}
#-------------VPC-------------#
variable "cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.10.0.0/16"
}
variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type        = bool
  default     = true
}
variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = true
}
#-------------Subnets-------------#
variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    type              = string # "public" or "private"
  }))
}
