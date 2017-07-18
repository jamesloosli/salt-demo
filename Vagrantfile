Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "centos/7"

  ## Networking
 
  ## Define some hosts
  config.vm.define "master" do |master|
    
    ## Network
    master.vm.hostname = "master"
    master.vm.network "private_network", virtualbox__intnet: true, ip: "192.168.50.10"

    ## Salt
    master.vm.provision :salt do |salt|

      ## Install the salt master
      salt.install_master = true
      salt.version = "2015.8.8"
      salt.minion_id = "master"

      ## Keys
      salt.master_key = "keys/master.pem"
      salt.master_pub = "keys/master.pub"
      salt.minion_key = "keys/master-minion.pem"
      salt.minion_pub = "keys/master-minion.pub"
      salt.seed_master = {
        master:"keys/master-minion.pub", 
        thing1:"keys/thing1.pub", 
        thing2:"keys/thing2.pub"
      }

    end

    ## Saltmaster Host
    master.vm.provision :hosts do |hosts|
      hosts.add_host '192.168.50.10', ['salt']
    end

    ## Saltmaster Role grain
    master.vm.provision :shell do |shell|
      shell.inline = "echo 'role: saltmaster' > /etc/salt/grains"
    end

    ## AWS Key
    master.vm.provision :file do |file|
      file.source = "~/.aws/credentials"
      file.destination = "/tmp/credentials"
    end

  end

  config.vm.define "thing1" do |thing1|

    ## Network
    thing1.vm.hostname = "thing1"
    thing1.vm.network "private_network", virtualbox__intnet: true, ip: "192.168.50.11"

    ## Salt
    thing1.vm.provision :salt do |salt|

      salt.minion_config = "etc/salt/minion"
      salt.version = "2015.8.8"
      salt.minion_id = "thing1"
      salt.minion_key = "keys/thing1.pem"
      salt.minion_pub = "keys/thing1.pub"
    
    end

    ## Saltmaster Host
    thing1.vm.provision :hosts do |hosts|
      hosts.add_host '192.168.50.10', ['salt']
    end

  end

  config.vm.define "thing2" do |thing2|

    ## Network
    thing2.vm.hostname = "thing2"
    thing2.vm.network "private_network", virtualbox__intnet: true, ip: "192.168.50.12"

    ## Salt
    thing2.vm.provision :salt do |salt|

      salt.minion_config = "etc/salt/minion"
      salt.version = "2015.8.8"
      salt.minion_id = "thing2"
      salt.minion_key = "keys/thing2.pem"
      salt.minion_pub = "keys/thing2.pub"
    
    end

    ## Saltmaster Host
    thing2.vm.provision :hosts do |hosts|
      hosts.add_host '192.168.50.10', ['salt']
    end

  end

end
