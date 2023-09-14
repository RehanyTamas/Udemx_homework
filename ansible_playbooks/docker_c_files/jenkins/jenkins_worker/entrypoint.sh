#!/bin/bash

cd /app
sleep 40 #Docker compose depend_on waits for the container to be readdy and not for the jenkins server inside of it, so it needs a bit of extra time to be ready for the connection

#Connect to jenkins master
curl -sO http://master:8080/jnlpJars/agent.jar
java -jar agent.jar -jnlpUrl http://master:8080/computer/worker%2D1/jenkins-agent.jnlp -workDir "/root"