####################################################################################################
### CA CERTIFICATE
####################################################################################################
resource "tls_private_key" "ca" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  is_ca_certificate = true

  subject {
    common_name = "Easy-RSA CA"
  }

  validity_period_hours = 336 //  7 days

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

####################################################################################################
### CLIENT CERTIFICATE
####################################################################################################
resource "tls_private_key" "client" {
  algorithm = "RSA"
}

resource "tls_cert_request" "client" {
  private_key_pem = tls_private_key.client.private_key_pem
  dns_names       = ["client.domain.ltd"]

  subject {
    common_name = "client.domain.ltd"
  }
}

resource "tls_locally_signed_cert" "client" {
  cert_request_pem   = tls_cert_request.client.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 336 //  7 days

  allowed_uses = [
    "digital_signature",
    # "key_encipherment",
    # "server_auth",
    "client_auth",
  ]
}

####################################################################################################
### SERVER CERTIFICATE
####################################################################################################
resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem
  dns_names       = ["server"]

  subject {
    common_name = "server"
  }
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 336 //  7 days

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
  ]
}

####################################################################################################
### ACM
####################################################################################################
resource "aws_acm_certificate" "server" {
  private_key       = tls_private_key.server.private_key_pem
  certificate_body  = tls_locally_signed_cert.server.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}

resource "aws_acm_certificate" "client" {
  private_key       = tls_private_key.client.private_key_pem
  certificate_body  = tls_locally_signed_cert.client.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}

####################################################################################################
### VAULT SECRETS
####################################################################################################
resource "hcp_vault_secrets_app" "vpn" {
  app_name    = "vpn"
  description = "This app contains ssh keys for AWS Client VPN"
}

resource "hcp_vault_secrets_secret" "ca_cert" {
  app_name     = hcp_vault_secrets_app.vpn.app_name
  secret_name  = "ca_cert"
  secret_value = tls_self_signed_cert.ca.cert_pem
}

resource "hcp_vault_secrets_secret" "ca_key" {
  app_name     = hcp_vault_secrets_app.vpn.app_name
  secret_name  = "ca_key"
  secret_value = tls_private_key.ca.private_key_pem
}

resource "hcp_vault_secrets_secret" "client_cert" {
  app_name     = hcp_vault_secrets_app.vpn.app_name
  secret_name  = "client_cert"
  secret_value = tls_locally_signed_cert.client.cert_pem
}

resource "hcp_vault_secrets_secret" "client_key" {
  app_name     = hcp_vault_secrets_app.vpn.app_name
  secret_name  = "client_key"
  secret_value = tls_private_key.client.private_key_pem
}

resource "hcp_vault_secrets_secret" "server_cert" {
  app_name     = hcp_vault_secrets_app.vpn.app_name
  secret_name  = "server_cert"
  secret_value = tls_locally_signed_cert.server.cert_pem
}

resource "hcp_vault_secrets_secret" "server_key" {
  app_name     = hcp_vault_secrets_app.vpn.app_name
  secret_name  = "server_key"
  secret_value = tls_private_key.server.private_key_pem
}

####################################################################################################
### VPN CLIENT 
####################################################################################################
resource "aws_security_group_rule" "vpn_client" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.client_vpn_endpoint_sg_id
}

resource "aws_ec2_client_vpn_endpoint" "this" {
  description            = "develop-client-vpn"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = "192.168.0.0/22"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client.arn
  }

  connection_log_options {
    enabled = false
  }

  vpc_id             = local.vpc_id
  security_group_ids = [local.client_vpn_endpoint_sg_id]
  split_tunnel       = true
}

resource "aws_ec2_client_vpn_network_association" "private_subnet" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = local.private_subnet_id
}

resource "aws_ec2_client_vpn_authorization_rule" "example" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = local.target_network_cidr
  authorize_all_groups   = true
}