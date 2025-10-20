variable "project_id" {
    description = "The ID of the project."
    type = string
    default = "cloudregops"
  
}

variable "region" {
    default = "us-central1"
}

variable "zone" {
    default = "us-central1-a"
}

variable "vpc" {
    default = "vpc-cloudregops"
}

variable "subnet" {
    default = "subnet-us-central1"
}