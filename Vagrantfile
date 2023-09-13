# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.define "udemx_hazi"
  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 80, host: 9000 #Docker registry port
  config.vm.network "forwarded_port", guest: 9001, host: 9001 #Jenkins port
  config.vm.network "forwarded_port", guest: 8080, host: 9002 #Nginx port
  config.vm.network "forwarded_port", id: "ssh", host: 2223, guest: 22 #SSH port
  config.vm.network "forwarded_port", guest: 81, host: 9003 #Laravel port
  config.vm.network "forwarded_port", guest: 443, host: 9004 #Laravel port
  config.vm.network "forwarded_port", guest: 9005, host: 9005 #Laravel port
  


  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048  # 2GB of memory
  end  

   # Install sudo,htop, and Midnight Commander
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

  #Install OpenJDK 8 and 11 and set javac version to OpenJDK 8
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

  # Set javac version to OpenJDK 8
  config.vm.provision "shell", inline: <<-SHELL
    update-alternatives --set java /opt/jdk8u382-b05/bin/java
    update-alternatives --set javac /opt/jdk8u382-b05/bin/javac
  SHELL

  # Install and configure fail2ban for SSH and Nginx
  config.vm.provision "shell", inline: <<-SHELL
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y fail2ban 
  SHELL

  config.vm.provision "shell" , inline: <<-SHELL

  SHELL

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/download_required.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/docker_c_start.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/scripts.yml"
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

