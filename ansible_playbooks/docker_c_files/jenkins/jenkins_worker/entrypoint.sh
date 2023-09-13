#!/bin/bash
cd /app
sleep 40
curl -sO http://master:8080/jnlpJars/agent.jar
java -jar agent.jar -jnlpUrl http://master:8080/computer/worker%2D1/jenkins-agent.jnlp -workDir "/root"