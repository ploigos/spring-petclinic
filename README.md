buildah bud -t e2e-jenkins e2e-jenkins.Containerfile
docker run --name=jenkins -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure e2e-jenkins
docker logs -f jenkins
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
