provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_key
  region = var.aws_region
  version = "~> 2.60"
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
  version = "~> 1.5"
}

provider "tls" {
  version = "~> 2.1"
}
