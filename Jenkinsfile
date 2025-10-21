pipeline {
    agent any


environment {
    PROJECT_ID = 'cloudregops'
    REGION = 'us-central1'
    REPO = 'bulletin-board'
    IMAGE = "${REPO}/bulletin-board"
    GCP_SA_CREDENTIALS_ID = 'gcp-sa-key'
    GITHUB_CREDENTIALS = '86752ebe-28fe-48cb-b985-fc4a918ee0b5'

}

stages {
    stage('Checkout'){
        steps{
            checkout scm
        }
    }

    stage('Setup Gcloud'){
        steps{
            withCredentials([file(credentialsId: env.GCP_SA_CREDENTIALS_ID, variable: 'GCP_KEYFILE')]){
                sh '''
                    echo "Autenticando gcloud..."
                    gcloud auth activate-service-account --key-file=$GCP_KEYFILE
                    gcloud config set project ${PROJECT_ID}
                    gcloud auth configure-docker ${REGION}-docker.pkg.dev -q || true
                '''
            }

        }
    }

    stage('Build Docker Images'){
        steps {
            script {
                COMMIT=sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                IMAGE_TAG="us-central1-docker.pkg.dev/cloudregops/bulletin-board/bulletin-board:${COMMIT}"
            }
            sh '''
                docker build -t ${IMAGE_TAG} -f bulletin-board-app/Dockerfile .
            '''
        }
    }

    stage('Push Image'){
        steps {
            sh '''
                docker push ${IMAGE_TAG}
            '''
        }
    }

    stage('Deploy to GKE'){
        steps {
        // Obtener credenciales del cluster y aplicar manifests
        withCredentials([file(credentialsId: env.GCP_SA_CREDENTIAL_ID, variable: 'GCP_KEYFILE')]) {
          sh '''
            gcloud auth activate-service-account --key-file=$GCP_KEYFILE
            gcloud config set project ${PROJECT_ID}
            # Obtener credenciales del cluster (ajusta nombre/zone)
            gcloud container clusters get-credentials bulletin-board-prod --region us-central1 --project cloudregops            # Reemplazar imagen en manifest y aplicar
            sed -e "s|IMAGE_PLACEHOLDER|${IMAGE_TAG}|g" k8s/deployment.yaml | kubectl apply -f -
            kubectl apply -f k8s/service.yaml
          '''
        }

        }   
    }

    stage('Post-deploy smoke test'){
        steps {
            sh '''
                kubectl rollout status deployment/bulletin-board-deployment --timeout=120s
            '''
        }
    }
}

post {
    success {
        echo 'Despliegue exitoso!'
    } 
    failure{
        echo 'Pipeline Fallo'
    }
 }

}

