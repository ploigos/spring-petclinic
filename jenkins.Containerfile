FROM jenkins/jenkins:lts-jdk11

USER root

# Install tools used by pipelines
RUN apt-get update && apt-get install -y python3 pip maven npm skopeo podman

# Install Ploigos Step Runner (psr)
RUN pip3 install --upgrade git+https://github.com/ploigos/ploigos-step-runner.git@main

USER jenkins

