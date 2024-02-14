path "sys/namespaces/test" {
	capabilities = ["create", "update", "delete"]
}

path "sys/mounts" {
  capabilities = ["read"]
}

path "sys/mounts/apps" {
  capabilities = ["create", "update", "read", "delete"]
}

path "apps/+/infra/boundary" {
  capabilities = ["create", "update", "read", "delete"]
}

path "sys/mounts/ssh-client-signer" {
  capabilities = ["create", "update", "delete"]
}

path "ssh-client-signer/config/ca" {
  capabilities = ["update", "read", "delete"]
}

path "sys/policies/acl/boundary-controller" {
  capabilities = ["create", "update", "read", "delete"]
}

path "sys/policies/acl/ssh" {
  capabilities = ["create", "update", "read", "delete"]
}

path "ssh-client-signer/roles/boundary-client" {
  capabilities = ["update", "read", "delete"]
}

path "auth/token/create" {
  capabilities = ["create", "update", "sudo"]
}

path "auth/token/lookup-accessor" {
  capabilities = ["create", "update"]
}
