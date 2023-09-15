# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.define "udemx_hazi"
  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 9000, host: 9000 #Docker registry port
  config.vm.network "forwarded_port", guest: 9001, host: 9001 #Jenkins port
  config.vm.network "forwarded_port", guest: 80, host: 9002 #Nginx port
  config.vm.network "forwarded_port", id: "ssh", host: 2223, guest: 22 #SSH port
  config.vm.network "forwarded_port", guest: 9003, host: 9003 #Json project port
  config.vm.network "forwarded_port", guest: 9004, host: 9004 #Hello_world_ansible port
  config.vm.network "forwarded_port", guest: 9005, host: 9005 #Hello_world_jenkins port
  


  config.vm.provider "virtualbox" do |vb|
    vb.memory = 3072  # 3GB of memory
  end  

   # Install sudo,htop,Midnight Commander and gnupg
  config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   DEBIAN_FRONTEND=noninteractive apt-get install -y sudo htop mc gnupg
  SHELL

  # Set root password to Alma1234
  config.vm.provision "shell", inline: <<-SHELL
    echo 'root:Alma1234' | chpasswd
  SHELL

  # Create a my own user
  config.vm.provision "shell", inline: <<-SHELL
    useradd -m -s /bin/bash r_tamas
    echo 'r_tamas:r_tamas_password' | chpasswd
  SHELL

  # Create user "udemx"
  config.vm.provision "shell", inline: <<-SHELL
   useradd -m -s /bin/bash -d /opt/udemx udemx
   echo 'udemx:udemx_password' | chpasswd
  SHELL

  #Set ssh key in place
  config.vm.provision "shell", inline: <<-SHELL
   sudo bash -c 'cp /vagrant/keys/udemx_hw_key /home/vagrant/.ssh/udemx_hw_key' 
   eval "$(ssh-agent -s)"
   ssh-add /home/vagrant/.ssh/udemx_hw_key
  SHELL

  # Install OpenJDK 8
  config.vm.provision "shell", inline: <<-SHELL
    wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u382-b05/OpenJDK8U-jdk_x64_linux_hotspot_8u382b05.tar.gz
    tar -xvf OpenJDK8U-jdk_x64_linux_hotspot_8u382b05.tar.gz
    sudo mv jdk8u382-b05  /opt/
    sudo update-alternatives --install /usr/bin/java java /opt/jdk8u382-b05/bin/java 2000
    sudo update-alternatives --install /usr/bin/javac javac /opt/jdk8u382-b05/bin/javac 2000
  SHELL

  # Install OpenJDK 11 
  config.vm.provision "shell", inline: <<-SHELL
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-11-jdk
  SHELL

  # Set java and javac version to OpenJDK 8
  config.vm.provision "shell", inline: <<-SHELL
    update-alternatives --set java /opt/jdk8u382-b05/bin/java
    update-alternatives --set javac /opt/jdk8u382-b05/bin/javac
  SHELL

  # Install fail2ban
  config.vm.provision "shell", inline: <<-SHELL
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y fail2ban 
  SHELL

  # Install git,docker and docker-compose
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/download_required.yml"
  end

  # Start docker containers
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/docker_c_start.yml"
  end

  # Execute sh scripts
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/scripts.yml"
  end

  # Execute ansible job (deploy docker image from private repo)
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/registry_job.yml"
  end

  #Rotate logs from nginx container
  config.vm.provision "shell", inline: <<-SHELL
    sudo echo '/var/log/nginx/*.log {
      rotate 7
      missingok
      copytruncate
      rotate 52
      compress
      delaycompress
    }' > /etc/logrotate.d/nginx
  SHELL

  #Enable  fail2ban jails
  config.vm.provision "shell", inline: <<-SHELL
    sudo echo '[nginx-botsearch]
    enabled = true
    
    [nginx-http-auth]
    enabled = true
    
    [nginx-limit-req]
    enabled = true' > /etc/fail2ban/jail.local
  SHELL

  # Restart the Fail2Ban service
  config.vm.provision "shell", inline: <<-SHELL
    sudo service fail2ban restart
  SHELL

end

