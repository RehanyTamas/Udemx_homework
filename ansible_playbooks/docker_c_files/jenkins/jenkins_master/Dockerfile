FROM jenkins/jenkins:lts


COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

ENV JENKINS_HOME /var/jenkins_home

ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

RUN jenkins-plugin-cli --plugins < /usr/share/jenkins/ref/plugins.txt
