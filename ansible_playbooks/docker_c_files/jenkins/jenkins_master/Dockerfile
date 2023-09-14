FROM jenkins/jenkins:lts

# Copy plugin list,JCasC and job files
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY jenkins-configuration.yaml /var/jenkins_home/jenkins-configuration.yaml
COPY docker_job.groovy /usr/local/docker_job.groovy

# Disable setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Set env variable to JCasC file
ENV CASC_JENKINS_CONFIG /var/jenkins_home/jenkins-configuration.yaml

# Install plugins
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
