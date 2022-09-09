FROM jenkins/jenkins:lts-jdk11
# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y python3 pip maven npm skopeo podman
RUN pip3 install --upgrade git+https://github.com/ploigos/ploigos-step-runner.git@main
COPY jenkins-job.xml var/jenkins_home/jobs/e2e/config.xml
# drop back to the regular jenkins user - good practice
USER jenkins

