# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.define "udemx_hazi"
  config.vm.box_check_update = false

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
   useradd -m -s /bin/bash udemx
   echo 'udemx:udemx_password' | chpasswd
  SHELL

  # Install sudo,htop, and Midnight Commander
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y sudo htop mc
  SHELL

  # Install OpenJDK 8 and 11 and set javac version to OpenJDK 8
  #config.vm.provision "shell", inline: <<-SHELL
    sudo bash -c 'echo "deb http://deb.debian.org/debian/ sid main" >> /etc/apt/sources.list'
  ##  sudo apt-get update
  #  yes | sudo apt-get install -y openjdk-8-jdk
 # SHELL

  # Install OpenJDK 11 
  #config.vm.provision "shell", inline: <<-SHELL
    #sudo apt-get install -y openjdk-11-jdk
  #SHELL

  # Set javac version to OpenJDK 8
  #config.vm.provision "shell", inline: <<-SHELL
   # update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
  #  update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
 # SHELL

  # Install and configure fail2ban for SSH and Nginx
  #config.vm.provision "shell", inline: <<-SHELL
    #sudo apt-get install -y fail2ban
   # sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   # echo "[sshd]  enabled = true
   # [nginx-http-auth]  enabled = true" >> /etc/fail2ban/jail.local
   # sudo systemctl restart fail2ban
 # SHELL
end

