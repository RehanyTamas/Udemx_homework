FROM openjdk:11

# Install docker
RUN apt-get update && apt-get install -y docker.io 

# Connect to master
WORKDIR /app
COPY entrypoint.sh .
ENTRYPOINT [ "/bin/sh", "/app/entrypoint.sh" ]