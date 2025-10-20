variable "project_id" {
    description = "GCP Project ID"
    type = string
    default = "cloudregops"
}

variable "region" {
    description = "GCP Region"
    default = "us-central1"
}

variable "zone" {
    description = "GCP Zone"
    default = "us-central1-a"
}
