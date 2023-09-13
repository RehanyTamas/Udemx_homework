FROM openjdk:11

RUN apt-get update && apt-get install -y docker.io 
#&& usermod -aG docker $USER

#ENTRYPOINT ["curl", "-O", "http://master:8080/jnlpJars/agent.jar", "&&", "java", "-jar", "agent.jar", "-jnlpUrl",  "http://master:8080/computer/worker%2D1/jenkins-agent.jnlp", "-workDir", "/home/jenkins" ]
WORKDIR /app
COPY entrypoint.sh .
ENTRYPOINT [ "/bin/sh", "/app/entrypoint.sh" ]