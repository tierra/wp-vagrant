#!/usr/bin/env bash

apt-get update

mkdir -p /etc/suphp
cp /vagrant/environments/files/suphp.conf /etc/suphp/suphp.conf

if [ ! -d /etc/puppetlabs/code/modules/apache ]; then
	puppet module install --modulepath /etc/puppetlabs/code/modules puppetlabs/apache;
fi

if [ ! -d /etc/puppetlabs/code/modules/mysql ]; then
	puppet module install --modulepath /etc/puppetlabs/code/modules puppetlabs/mysql;
fi

if [ ! -f /usr/local/bin/phpunit ]; then
	curl --silent --show-error --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-4.8.5.phar
fi
chmod +x /usr/local/bin/phpunit
