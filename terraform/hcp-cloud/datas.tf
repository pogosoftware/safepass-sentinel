data "hcp_iam_policy" "viewer" {
  bindings = [
    {
      role = "roles/viewer"
      principals = [
        hcp_service_principal.viewer.resource_id
      ]
    },
  ]
}
