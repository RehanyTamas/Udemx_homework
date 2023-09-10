# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.define "udemx_hazi"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 80, host: 9000
  config.vm.network "forwarded_port", guest: 9001, host: 9001
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048  # 2GB of memory
  end

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
    DEBIAN_FRONTEND=noninteractive apt-get install -y sudo htop mc #gnupg
  SHELL

  #config.vm.provision "shell", inline: <<-SHELL
  #  echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment
  #  echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
  #  echo "LANG=en_US.UTF-8" | sudo tee -a /etc/locale.conf
  #  sudo locale-gen en_US.UTF-8
  #SHELL

  # Install OpenJDK 8 and 11 and set javac version to OpenJDK 8
  #config.vm.provision "shell", inline: <<-SHELL
  #  sudo bash -c 'echo "deb http://deb.debian.org/debian/ sid main" >> /etc/apt/sources.list'
  #  sudo apt-get update
  #  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk #|| true
  #SHELL

  # Install OpenJDK 11 
  #config.vm.provision "shell", inline: <<-SHELL
  # sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-11-jdk #|| true
  #SHELL

  # Set javac version to OpenJDK 8
  #config.vm.provision "shell", inline: <<-SHELL
  #  update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
  #  update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
  #SHELL

  # Install and configure fail2ban for SSH and Nginx
  config.vm.provision "shell", inline: <<-SHELL
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y fail2ban #|| true
  SHELL

  #config.vm.provision "shell", inline: <<-SHELL
  #  cp /vagrant/fail2ban_files/jail.local /etc/fail2ban/jail.local
  #  cp /vagrant/fail2ban_files/nginx-auth.conf /etc/fail2ban/filter.d/nginx-auth.conf
  #  sudo systemctl restart fail2ban
  #SHELL

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/download_required.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible_playbooks/docker_c_start.yml"
  end


end

