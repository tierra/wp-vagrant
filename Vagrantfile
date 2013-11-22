# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'local'

Vagrant.configure("2") do |config|

  config.vm.define 'wordpress-php52' do |node|
    node.vm.box = 'wordpress-php52'
    node.vm.box_url = 'http://wp.ibaku.net/wordpress-php52.box'
    node.vm.hostname = node.vm.box + '.' + domain
    node.vm.network :private_network, ip: '192.168.167.9'

    node.vm.provider :virtualbox do |vb|
      vb.customize [
        'modifyvm', :id,
        '--name', node.vm.box,
        '--memory', '512',
      ]
    end
  end

  config.vm.define 'wordpress-php53', primary: true do |node|
    node.vm.box = 'wordpress-php53'
    node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
    node.vm.hostname = node.vm.box + '.' + domain
    node.vm.network :private_network, ip: '192.168.167.10'

    node.vm.provider :virtualbox do |vb|
      vb.customize [
        'modifyvm', :id,
        '--name', node.vm.box,
        '--memory', '512',
      ]
    end

    node.vm.provision :shell, :path => "puppet/bootstrap.sh"
    node.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "wordpress-php53.pp"
    end
  end

end
