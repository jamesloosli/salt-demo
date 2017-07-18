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

## Bonus Points
If you self-identify as an AWS Devops Engineer, there is an aws networking state that will build you a basic VPC environment. 
