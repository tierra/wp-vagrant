#!/usr/bin/env bash

apt-get update --fix-missing

mkdir -p /etc/suphp
cp /vagrant/puppet/files/suphp.conf /etc/suphp/suphp.conf

if [ ! -d /etc/puppet/modules/apt ]; then
	puppet module install puppetlabs/apt;
fi

if [ ! -d /etc/puppet/modules/apache ]; then
	puppet module install puppetlabs/apache;
fi

if [ ! -d /etc/puppet/modules/mysql ]; then
	puppet module install puppetlabs/mysql;
fi

if [ ! -d /etc/puppet/modules/pear ]; then
	puppet module install rafaelfc/pear;
fi
