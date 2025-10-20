terraform {
  backend "gcs" {
    bucket = "tfstate-cloudregops"
    prefix = "bulletin-board/terraform"
  }
}

