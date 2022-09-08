pipeline {
    agent {
        docker {
            docker { image 'quay.io/ploigos/ploigos-github-runner' }
        }
    }

    stages {
        stage('Generate Metadata') {
            steps {
                sh "psr -s unit-test -c psr.yaml"
            }
        }
        stage('Unit Test') {
            steps {
                sh "psr -s unit-test -c psr.yaml"
            }
        }
        stage('Package') {
            steps {
                sh "psr -s package -c psr.yaml"
            }
        }
        stage('Create Container Image') {
            steps {
                sh "psr -s create-container-image -c psr.yaml"
            }
        }
    }
}

