# resource "google_service_account" "jenkins_sa" {
#     account_id = "jenkins-sa"
#     display_name = "Jenkins Service Account"
#     project = var.project_id
  
# }

# resource "google_project_iam_member" "jenkins_artifact" {
#     project = var.project_id
#     role = "roles/artifactregistry.writer"
#     member = "serviceAccount:${google_service_account.jenkins_sa.email}"
  
# }

# resource "google_project_iam_member" "jenkins_gke" {
#     project = var.project_id
#     role = "roles/artifactregistry.writer"
#     member = "serviceAccount:${google_service_account.jenkins_sa.email}"
  
# }