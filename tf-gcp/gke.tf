# resource "google_container_cluster" "primary" {
#     name = "bulletin-board-cluster"
#     location = var.zone
#     project = var.project_id
#     initial_node_count = 2

#     node_config {
#       machine_type = "e2-medium"
#       oauth_scopes = [
#         "https://www.googleapis.com/auth/cloud-platform"
#       ]
#     }

#     deletion_protection = false
# }