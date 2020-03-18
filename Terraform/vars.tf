variable "public_key_path"{
  default = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  type = "map"
  default = {
    Repo = "https://github.com/GeethP91/MyInfraProject"
    Terraform = true
  }
}