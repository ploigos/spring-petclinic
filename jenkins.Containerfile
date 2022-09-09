FROM jenkins/jenkins:lts-jdk11

USER root

# Install tools used by pipelines
RUN apt-get update && apt-get install -y python3 pip maven npm skopeo podman
#RUN pip3 install --upgrade git+https://github.com/ploigos/ploigos-step-runner.git@main

# Configure an example Job
#COPY jenkins-job.xml /var/jenkins_home/jobs/e2e/config.xml
#RUN chown jenkins: /var/jenkins_home/jobs/e2e/config.xml

USER jenkins

