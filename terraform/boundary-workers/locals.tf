locals {
  boundary_cluster_url                  = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_url
  boundary_username                     = data.hcp_vault_secrets_secret.boundary_username.secret_value
  boundary_password                     = data.hcp_vault_secrets_secret.boundary_password.secret_value
  boundary_hcp_cluster_id               = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_id
  controller_generated_activation_token = boundary_worker.egress_worker.controller_generated_activation_token

  public_key_openssh = data.hcp_vault_secrets_secret.public_key_openssh.secret_value

  ami = data.aws_ami.ubuntu.id

  egress_worker_sg_id     = data.terraform_remote_state.network.outputs.security_group_ids["egress-worker"]
  egress_worker_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]

  user_data = <<-EOT
    #!/bin/bash
    apt update
    apt install -y awscli jq unzip wget

    wget -q "$(curl -fsSL "https://api.releases.hashicorp.com/v1/releases/boundary/latest?license_class=enterprise" | jq -r '.builds[] | select(.arch == "amd64" and .os == "linux") | .url')"
    unzip *.zip -d /usr/local/bin
    chmod +x /usr/local/bin/boundary

    groupadd boundary
    useradd -m -d /etc/boundary.d -r -g boundary -s /bin/bash boundary

    mkdir -p /var/lib/boundary
    chown -R boundary:boundary /var/lib/boundary
    chmod -R 750 /var/lib/boundary

    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    HOSTNAME=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/hostname)

    # Create egress-worker.hcl file
    cat <<CONTENT > /etc/boundary.d/egress-worker.hcl
    hcp_boundary_cluster_id = "${local.boundary_hcp_cluster_id}"

    listener "tcp" {
      address = "0.0.0.0:9202"
      purpose = "proxy"
    }
            
    worker {
      public_addr = "$HOSTNAME"
      controller_generated_activation_token = "${local.controller_generated_activation_token}"
      auth_storage_path = "/var/lib/boundary"
      tags {
        worker = ["egress"]
      }
    }
    CONTENT
    chown boundary:boundary /etc/boundary.d/egress-worker.hcl
    chmod -R 750 /etc/boundary.d/egress-worker.hcl

    # Create boundary.service file
    cat <<CONTENT > /etc/systemd/system/boundary.service
    [Unit]
    Description=Hashicorp Boundary Egress Worker

    [Service]
    ExecStart=/usr/local/bin/boundary server -config /etc/boundary.d/egress-worker.hcl
    User=boundary
    Group=boundary
    LimitMEMLOCK=infinity
    Capabilities=CAP_IPC_LOCK+ep
    CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK

    [Install]
    WantedBy=multi-user.target
    CONTENT

    # Start the Boundary service
    systemctl enable boundary
    systemctl start boundary
    
    # Configure Vault ca-key.pub ssh key
    cat <<CONTENT > /etc/ssh/ca-key.pub
    ${local.public_key_openssh}
    CONTENT

    chown 1000:1000 /etc/ssh/ca-key.pub
    chmod 644 /etc/ssh/ca-key.pub
    echo TrustedUserCAKeys /etc/ssh/ca-key.pub >> /etc/ssh/sshd_config
    echo PermitTTY yes >> /etc/ssh/sshd_config
    sed -i 's/X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
    echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

    systemctl restart sshd
  EOT
}
