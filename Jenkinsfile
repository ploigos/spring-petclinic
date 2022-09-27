pipeline {
   agent {
        kubernetes {
            cloud 'openshift'
            yaml """
apiVersion: v1
kind: Pod
metadata:
    labels:
        git-repo-name: 'spring-petclinic'
        git-branch-name: 'feature_end-to-end'
        jenkins-build-id: ${env.BUILD_ID}
spec:
    serviceAccount: jenkins
    containers:
    - name: 'jnlp'
      image: "ploigos/ploigos-ci-agent-jenkins:latest"
      tty: true
      volumeMounts:
      - mountPath: '/home/ploigos'
        name: home-ploigos
    - name: 'default'
      image: "ploigos/ploigos-tool-maven:latest"
      tty: true
      volumeMounts:
      - mountPath: '/home/ploigos'
        name: home-ploigos
      ${PLATFORM_MOUNTS}
      ${TLS_MOUNTS}
    - name: 'buildah'
      image: 'ploigos/ploigos-tool-containers:latest'
      tty: true
      securityContext:
        capabilities:
            add:
            - 'SETUID'
            - 'SETGID'
      volumeMounts:
      - mountPath: '/home/ploigos'
        name: home-ploigos
    volumes:
    - name: home-ploigos
      emptyDir: {}
"""
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
    }
}

