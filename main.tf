# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html

data "http" "openid-configuration" {
  url = "${var.url}/.well-known/openid-configuration"
}

data "tls_certificate" "this" {
  url = "https://oidc.eks.us-east-1.amazonaws.com/id/2D36A2FEA9E563F1F19D18D8BA168986"
}

resource "aws_iam_openid_connect_provider" "this" {
  url = var.url

  client_id_list = var.client_id_list

  thumbprint_list = data.tls_certificate.this.certificates[*].sha1_fingerprint

  tags = var.tags
}
