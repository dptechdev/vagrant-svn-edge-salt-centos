Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-6.5-64-nocm"

  ## For masterless, mount your salt file root
  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  
  config.vm.network "forwarded_port", guest: 3343, host: 3343
  config.vm.network "forwarded_port", guest: 4434, host: 4434
  config.vm.network "forwarded_port", guest: 80, host: 8880

  ## Use all the defaults:
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end
end
