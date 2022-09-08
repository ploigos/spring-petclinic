pipeline {
    agent {
        docker {
            docker { image 'quay.io/ploigos/ploigos-github-runner' }
        }
    }

    stages {
        stage('Generate Metadata') {
            steps {
                psr -s unit-test -c psr.yaml
            }
        }
        stage('Unit Test') {
            steps {
                psr -s unit-test -c psr.yaml
            }
        }
        stage('Package') {
            steps {
                psr -s package -c psr.yaml
            }
        }
        stage('Create Container Image') {
            steps {
                psr -s create-container-image -c psr.yaml
            }
        }
    }
}

