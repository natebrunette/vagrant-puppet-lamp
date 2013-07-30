# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :twinsix do |config|
        config.vm.box = "precise32"
        config.vm.box_url = "http://files.vagrantup.com/precise32.box"
        config.vm.customize ["modifyvm", :id, "--rtcuseutc", "on", "--memory", 4000]
        config.ssh.max_tries = 10
        config.vm.forward_port 80, 8888
        config.vm.forward_port 3306, 8889
        config.vm.host_name = "twinsix"
  		config.vm.share_folder("www", "/var/www", "htdocs", :extra => 'dmode=777,fmode=777')

  		config.vm.provision :shell, :inline => "echo \"America/Chicago\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "phpbase.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
            #puppet.options = "--verbose"
        end
        
        config.vm.provision :shell, :path => "puppet/scripts/enable_remote_mysql_access.sh"

    end
end
