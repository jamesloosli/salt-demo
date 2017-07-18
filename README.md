# salt-demo
A few demo files for an internal saltstack class.

## Basic Setup
This relies largely on [Vagrant](https://www.vagrantup.com/intro/index.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

Behold an copy-pasta;

```
# You're on an apple laptop aren't you.
brew install -y caskroom/cask/vagrant

# Install a few vagrant plugins
vagrant plugin install vagrant-hosts vagrant-vbguest

# Ready to roll
vagrant up

# (Optional) Get on the saltmaster and give it a try
vagrant ssh master
```
## Post Setup tasks
```
# Deploy the latest
sudo -i
cd /vagrant
bin/deploy.sh

# Highstate the saltmaster
salt -G role:saltmaster state.highstate
```

## Bonus Points
If you self-identify as an AWS Devops Engineer, there is an aws networking state that will build you a basic VPC environment. 

```
# From the saltmaster
salt-call --local state.apply tasks.aws.vpc_init
```

There are also some salt-cloud profiles. Inspect `etc/salt/cloud.profiles.d/` for more info.
