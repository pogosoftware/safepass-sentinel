path "${vault_ssh_mount_path}/issue/${vault_ssh_role_name}" {
  capabilities = ["create", "update"]
}

path "${vault_ssh_mount_path}/sign/${vault_ssh_role_name}" {
  capabilities = ["create", "update"]
}
