variable "rgname" {
    type = string
    description = "Resource group name"

}

variable "rglocation" {
    type = string
    description = "Resource group location"

}


variable "envn" {
    type = string
    description = "Environment"
}

variable "aksname" {
    type = string
    description = "AKS Name"
}

variable "aksdns" {
    type = string
    description = "DNS"
}


variable "aksnpname" {
    type = string
    description = "AKS Name"
}
variable "acr_id" {
  description = "The ID of the Azure Container Registry"
  type        = string
}