# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define 'wordpress-php52', autostart: false do |node|
    node.vm.box = 'tierra/wordpress-php52'
    node.vm.hostname = 'wordpress-php52.local'
    node.vm.network :private_network, ip: '192.168.167.9'

    node.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end
  end

  config.vm.define 'wordpress-php53', primary: true do |node|
    node.vm.box = 'ubuntu/precise64'
    node.vm.hostname = 'wordpress-php53.local'
    node.vm.network :private_network, ip: '192.168.167.10'

    node.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    node.vm.provision :shell, :path => "puppet/bootstrap.sh"
    node.vm.provision :puppet do |puppet|
      puppet.facter = { 'fqdn' => node.vm.hostname }
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "wordpress-php53.pp"
      puppet.options = "--hiera_config /etc/hiera.yaml"
    end
  end

  config.vm.define 'wordpress-php54', autostart: false do |node|
    node.vm.box = 'debian/wheezy64'
    node.vm.hostname = 'wordpress-php54.local'
    node.vm.network :private_network, ip: '192.168.167.11'

    node.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    node.vm.provision :shell, :path => "puppet/bootstrap.sh"
    node.vm.provision :puppet do |puppet|
      puppet.facter = { 'fqdn' => node.vm.hostname }
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "wordpress-php54.pp"
      puppet.options = "--hiera_config /etc/hiera.yaml"
    end
  end

  config.vm.define 'wordpress-php55', autostart: false do |node|
    node.vm.box = 'ubuntu/trusty64'
    node.vm.hostname = 'wordpress-php55.local'
    node.vm.network :private_network, ip: '192.168.167.12'

    node.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    node.vm.provision :shell, :path => "puppet/bootstrap.sh"
    node.vm.provision :puppet do |puppet|
      puppet.facter = { 'fqdn' => node.vm.hostname }
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "wordpress-php55.pp"
      puppet.options = "--hiera_config /etc/hiera.yaml"
    end
  end

end
