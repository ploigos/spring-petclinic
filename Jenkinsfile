pipeline {
   agent {
        kubernetes {
            cloud 'openshift'
            defaultContainer 'default'
            yamlFile 'kubernetes-pod.yaml'
        }
    }
    stages {
        stage('Generate Metadata') {
            steps {
                sh "psr -s generate-metadata -c psr.yaml"
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
        stage('Push Container Image') {
            steps {
                sh "psr -s push-container-image -c psr.yaml"
            }
        }
    }
}

