# How to run the example
* buildah bud -t e2e-jenkins e2e-jenkins.Containerfile
* podman run --name=jenkins -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure e2e-jenkins
* podman logs -f jenkins # wait until it says "Jenkins is fully up and running"
* podman exec -u jenkins -it jenkins podman login --authfile /var/jenkins_home/container-auth.json quay.io
* podman exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword # Copy this
* Setup Jenkins
  * Browse to http://localhost:8080
  * Paste the value you copied
  * Select "install suggested plugins". Wait.
  * Select "Skip and continue as admin"
  * Select "Save and Finish"
  * Select "Start using Jenkins"
* Create a Jenkins Job to build the app using the Jenkinsfile
  * Select "Create a job"
  * Type "ploigos-e2e"
  * Select "Pipeline"
  * Select "OK"
  * Under the "Pipeline" section, change the dropdown value from "Pipeline script" to "Pipeline script from SCM"
  * Under "SCM" change the dropdown value from "None" to "Git"
  * For "Repository URL", enter "https://github.com/ploigos/spring-petclinic.git"
  * For "Branch Specifier", enter "feature/end-to-end"
  * Under "Additional Behaviors", enter "Check out to specific local branch"
  * Under "Branch name", enter "feature/end-to-end"
  * *Uncheck* the checkbox for "Lightweight checkbox". Make sure the box is not checked.
  * Select "Save"
* Run the pipeline to build the example application
  * Select "Build now"
  * Watch the pipeline stages turn green.
  * You can view the log and other build details by selecting the current build in the "Build History" area. Click the round icon to the left of "#1" to open the logs directly.

