Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "centos/7"

  ## Control the synced folders more tightly
  config.vm.synced_folder ".", "/vagrant", disabled: true

  ## Use all the defaults:
  config.vm.define "master" do |master|
    config.vm.provision :salt do |salt|
      ## Sync salt code, master config
      config.vm.synced_folder "srv", "/srv"
      config.vm.synced_folder "etc/salt", "/etc/salt"
      ## Install the salt master
      salt.install_master = true
      salt.install_args = "git v2015.8.8"
      ## Pre-seed some keys
    end
  end
end
