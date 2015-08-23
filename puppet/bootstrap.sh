#!/usr/bin/env bash

apt-get install --yes lsb-release
DISTRIB_CODENAME=$(lsb_release --codename --short)
DEB="puppetlabs-release-${DISTRIB_CODENAME}.deb"
DEB_PROVIDES="/etc/apt/sources.list.d/puppetlabs.list"

if [ ! -e $DEB_PROVIDES ]
then
    wget -q http://apt.puppetlabs.com/$DEB
    sudo dpkg -i $DEB
fi

sudo apt-get update
sudo apt-get install --yes puppet

mkdir -p /etc/suphp
cp /vagrant/puppet/files/suphp.conf /etc/suphp/suphp.conf

if [ ! -d /etc/puppet/modules/apache ]; then
	puppet module install puppetlabs/apache;
fi

if [ ! -d /etc/puppet/modules/mysql ]; then
	puppet module install puppetlabs/mysql;
fi

if [ ! -f /usr/local/bin/phpunit ]; then
	curl --silent --show-error --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-4.8.5.phar
fi
chmod +x /usr/local/bin/phpunit
