resource "google_container_cluster" "autopilocluster" {
    name = "bulletin-board-prod"
    location = var.region
    project = var.project_id
    
    enable_autopilot = true

    logging_service    = "logging.googleapis.com/kubernetes"
    monitoring_service = "monitoring.googleapis.com/kubernetes"

    deletion_protection = false

}