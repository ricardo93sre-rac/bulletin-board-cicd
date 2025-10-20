resource "google_artifact_registry_repository" "bulletin_board" {
    location = var.region
    repository_id = "bulletin-board"
    description = "Docker repository for bulletin board app"
    format = "DOCKER"
    project = var.project_id
}

