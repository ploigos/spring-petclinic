docker run -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:lts-jdk11
docker exec beautiful_tharp cat /var/jenkins_home/secrets/initialAdminPassword
