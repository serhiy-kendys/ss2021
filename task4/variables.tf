variable "region" {
    type = string
}
variable "project" {
    type = string
}

variable "user" {
    type = string
}

variable "privatekeypath" {
    type = string
    default = "~/.ssh/id_rsa"
}

variable "publickeypath" {
    type = string
    default = "~/.ssh/id_rsa.pub"
}
