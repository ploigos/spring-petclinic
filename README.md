# End to End Ploigos Step Runner Example
This example application demonstrates how to use the Ploigos Step Runner (psr) and Jenkins to create a CI/CD pipeline that builds a simple application.

## Instructions
* Build the custom container image provided for running Jenkins
  * `buildah bud -t e2e-jenkins e2e-jenkins.Containerfile`
* Start Jenkins
  * `podman run --name=jenkins -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure e2e-jenkins`
* View the Jenkins logs. Wait until it says "Jenkins is fully up and running"
  * `podman logs -f jenkins`
* Login to the container registry and save the credentials in the Jenkins container's mounted volume so that the psr can use them
  * `podman exec -u jenkins -it jenkins podman login --authfile /var/jenkins_home/container-auth.json quay.io`
* Retrieve the initial admin password for Jenkins
  * `podman exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
* Perform the initial setup for Jenkins using the browser-based wizard
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
* Run the pipeline to build the example application.
  * Select "Build now"
  * Watch the pipeline stages turn green.
  * You can view the log and other build details by selecting the current build in the "Build History" area. Click the round icon to the left of "#1" to open the logs directly.

## What is happening when I run the example pipeline?
  * Jenkins reads the file named Jenkinsfile. It contains instructions that tell Jenkins what to do.
  * For each stage, Jenkins invokes the psr command.
  * The psr command consults the psr.yaml configuration file. For this example, the psr command has been installed directly into the Jenkins container for simplicity. It is good practice to use a separate container in production.
  * During each stage, the psr command invokes other commands (external tools). These commands have also been installed into the Jenkins container. The exernal tools include git, mvn, and buildah.

