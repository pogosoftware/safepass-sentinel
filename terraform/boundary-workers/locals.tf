locals {
  ami = data.aws_ami.ubuntu.id

  egress_worker_sg_id     = data.terraform_remote_state.network.outputs.security_group_ids["egress-worker"]
  egress_worker_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]

  user_data = <<-EOT
    #!/bin/bash
    apt update
    apt install -y awscli jq

    export HCP_CLIENT_ID=$(aws ssm get-parameter --name "hcp_client_id" --query "Parameter.Value" --output text --region eu-central-1)
    export HCP_CLIENT_SECRET=$(aws ssm get-parameter --name "hcp_client_secret" --with-decryption --query "Parameter.Value" --output text --region eu-central-1)
    
    HCP_API_TOKEN=$(curl --location 'https://auth.hashicorp.com/oauth/token' \
    --header 'content-type: application/json' \
    --data '{
    "audience": "https://api.hashicorp.cloud",
    "grant_type": "client_credentials",
    "client_id": "'$HCP_CLIENT_ID'",
    "client_secret": "'$HCP_CLIENT_SECRET'"
    }' | jq -r .access_token)

    curl \
    --location "https://api.cloud.hashicorp.com/secrets/2023-06-13/organizations/219ecfed-b7ce-49a3-a92a-6b323dcf9cd3/projects/d9720027-8bb1-4542-98a3-744da821d0cf/apps/vault/open" \
    --request GET \
    --header "Authorization: Bearer $HCP_API_TOKEN" | jq --raw-output '.secrets[] | select(.name | test("public_key_openssh")) | .version.value' > /etc/ssh/ca-key.pub

    chown 1000:1000 /etc/ssh/ca-key.pub
    chmod 644 /etc/ssh/ca-key.pub
    echo TrustedUserCAKeys /etc/ssh/ca-key.pub >> /etc/ssh/sshd_config
    echo PermitTTY yes >> /etc/ssh/sshd_config
    sed -i 's/X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
    echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

    systemctl restart sshd
  EOT
}
