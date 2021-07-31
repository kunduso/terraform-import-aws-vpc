#Define AWS Region
variable "region" {
  description = "Infrastructure region"
  type        = string
  default     = "us-east-2"
}
#Define IAM User Access Key
variable "access_key" {
  description = "The access_key that belongs to the IAM user"
  type        = string
  sensitive   = true
}
#Define IAM User Secret Key
variable "secret_key" {
  description = "The secret_key that belongs to the IAM user"
  type        = string
  sensitive   = true
}
variable "vpc_address_space" {
  type    = string
  default = "10.20.0.0/20"
}
variable "subnet_address_space" {
  type    = list(string)
  default = ["10.20.0.0/24", "10.20.1.0/24"]
}