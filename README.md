# Udemx Homework

This is my attempt at completing the tasks given to me during the first interview with Udemx.
This project will create a debian 11 based linux "server" in the form a virtual machine, which the,it will configure according to the specifications given to me.
(configuring vm attributes, installing technologies, running docker containers ...etc.)

## What technologies were used

- VirtualBox
- Vagrant
- Ansible
- Docker
- Docker-compose
- Jenkins
- MySql
- Nginx

## How to start

This project requires that your machine equipped with Virtualbox, Vagrant, Ansible, and Docker.

1. Clone this repository to your machine
2. Navigate to the project directory
3. Start
  ```sh
  vagrant up
  ```
4. Wait, this might take a while...

## Characteristics

### System

The password of root has been set to 'Alma1234'.

There are two addtional users:

    - username: r_tamas password: r_tamas_password
    - username: udemx password: udemx_password

Midnight Commander, sudo, htop and gnupg are available on the vm.

Both OpenJDK 8 and OpenJDK 11 have been installed.
  - Debian 11 doesn't provide OpenJDK 8 packages, so it was installed from tar file via Adoptium.
  - The default java and javac are both set to former.

The ssh port has been changed from the default 2222 to 2223.

Fail2ban is also installed and configured to ssh and nginx.
  - The configuration of this happens at the end of the vagrantfile.

### Ansible

Vagrant will also execute several ansible playbooks, which will install additional technologies and start docker containers.

The first one is named 'download_required.yml' and it will install git, docker and docker-compose.
    - The default user of git has been set to "udemx", its email to 'udemx@udemx.eu'.

The second in the line is 'docker_c_start.yml', the responsibility of which, is to execute four docker-compose files. These files can be found in the subfodlers of the 'ansible_playbooks/docker_c_files/' folder.

    1. basic_containers
        * This starts an NGINX and a MariaDB container, as well as a basic hello-world container
        * The former on port 80 the latter on port 3306 (its default)
        * The NGINX container can be accesed ourside of the vm on 'http://localhost:9002/'
        * In the MariaDB container the password of the root has been set to 'root_password' 
        * For the MariDB container a user (name: udemx password:udemx_password), a database (name:udemx-db) has been created, these can be modified in the docker-compose file
        * The priviliges of udemx user has also been configured. Currently they receive all priviligies. This can be modified in the grant_privilige.sql file which is located in the initdb folder next to the docker-compose file.

     2. 'docker_registry'
        * This one starts 2 containers. One is for a private docker registry and another to provide it with a ui. 
        * The registry can be accessed from the outside on 'http://localhost:9000/.
        * The registry can be configured in the docker-compose file

    3. 'jenkins' 
        * This starts a container for a Jenkins server, and another one as a jenkins node.
        * The server can be accessed from the outside on 'http://localhost:9001/'.  
        * The Jenkins master has been configured with the usage of Jenkins Configuration as Code'. It comes with plugins preinstalled, the node 'worker-1' and a job 'hello_world' created.
        * The Jenkins worker is equipped with docker.
        * If you build the 'hello_world' job it will clone a private github repository, build an image from the Dockerfile that is in it, upload it to the private registry (name:hello_world_jenkins) and the deploys it on the server.
        * The behaviour of the job can be changed with the 'docker_job.groovy' file , found in the jenkins_master folder.
        * The new container can be accessed at 'http://localhost:9005/'.

    4. 'json_project' 
        * This starts three containers (NGINX,MySQL, and one for the app) to facilitate the app that is also found in the folder.
        * This can be accessed from the outside on 'http://localhost:9003/'.
        * These can be changed by using the files in the folder (docker-compose included)

The third 'scripts.yml' executes the full_report.sh file, which then executes the others.These can be found in the shell_scripts folder and do the following things: 

    - Create a new folder in the '/opt/scripts/' folder named after the current. The ouput of the rest of the scripts can be found here (with the one exception). (source: dir_from_date.sh)
    - Create an sql dump from the MariaDb container. (source: sql_dump.sh)
    - List the three ast modified files from the '/var/log' folder in the 'mod-<DATE>.out' file. (source: mod.sh)
    - List the files that has been modified in the last 5 days from the '/var/log/*' folder in the 'last_five-<DATE>.out' file. (source: last_five.sh)
    - Write the 15 minute value from '/proc/loadvg' in the 'loadavg-<DATE>.out' file. (source: loadavg.sh)
    - In the configuration file of the GNINX container change '<title>Welcome to nginx!</title>' to 'Title:Welcome to nginx!</title>'. (source: nginx_conf.sh)
    
This one also creates a cronjob that executes 'full_report.sh' at 2AM everyday.

The last playbook ('registry_job.yml') does the same thing as the 'hello_world' job from the jenkins server, but does it via ansible.
    - The container created here can be accessed at 'http://localhost:9004/'
    

## Addendum

If the jenkins node seems to be not connected, wait a little, it might just not finished setting up yet.
If it remains disconnected restart its docker container.

## TODO

Configure iptable

todo mariadb setup
iptables
app?
