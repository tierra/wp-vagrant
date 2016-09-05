# -*- mode: ruby -*-
# vi: set ft=ruby :

def provision(node)
  node.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '512']
  end
  node.vm.provision :shell, :path => 'environments/bootstrap.sh'
  node.vm.provision :puppet do |puppet|
    puppet.environment_path = 'environments'
    puppet.environment = 'vagrant'
    puppet.facter = { 'fqdn' => node.vm.hostname }
  end
end

Vagrant.configure('2') do |config|

  config.vm.define 'wordpress-php52', autostart: false do |node|
    node.vm.box = 'tierra/wordpress-php52'
    node.vm.hostname = 'wordpress-php52.local'
    node.vm.network :private_network, ip: '192.168.167.9'
    node.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end
  end

  config.vm.define 'wordpress-php53', primary: true do |node|
    node.vm.box = 'puppetlabs/ubuntu-12.04-64-puppet'
    node.vm.box_version = '= 1.0.2'
    node.vm.hostname = 'wordpress-php53.local'
    node.vm.network :private_network, ip: '192.168.167.10'
    provision(node)
  end

  config.vm.define 'wordpress-php54', autostart: false do |node|
    node.vm.box = 'puppetlabs/debian-7.8-64-puppet'
    node.vm.hostname = 'wordpress-php54.local'
    node.vm.network :private_network, ip: '192.168.167.11'
    provision(node)
  end

  config.vm.define 'wordpress-php55', autostart: false do |node|
    node.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'
    node.vm.hostname = 'wordpress-php55.local'
    node.vm.network :private_network, ip: '192.168.167.12'
    provision(node)
  end

end
