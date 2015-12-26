
apt::source { 'non_free':
  location => 'http://http.us.debian.org/debian',
  release  => 'jessie',
  repos    => 'main contrib non-free',
  include  => { 'src' => true, 'deb' => true }
}

package { [
  'augeas-tools',
  'build-essential',
  'curl',
  'git',
  'php5-cli',
  'php5-curl',
  'php5-gd',
  'php5-imagick',
  'php5-mcrypt',
  'php5-mysql',
  'php5-xdebug',
  'subversion'
]: ensure => latest }

exec { 'nodesource':
  command => '/usr/bin/curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -',
  require => Package['curl']
}
package { 'nodejs':
  ensure => latest,
  require => Exec['nodesource']
}
exec { 'grunt-cli':
  command => '/usr/bin/npm install -g grunt-cli',
  creates => '/usr/bin/grunt',
  require => Package['nodejs']
}

include php
include php::composer
include php::composer::auto_update

class { 'php::fpm':
  require => Package['augeas-tools']
}
php::fpm::pool { 'www':
  user                 => 'vagrant',
  group                => 'vagrant',
  listen               => '127.0.0.1:9000',
  pm                   => 'ondemand',
  pm_max_children      => '5',
  pm_start_servers     => '1',
  pm_min_spare_servers => '1',
  pm_max_spare_servers => '2',
  pm_max_requests      => '1000',
}

class { 'apache': }

apache::mod { [
  'actions',
  'rewrite'
]: }

apache::vhost { 'wordpress':
  servername       => $fqdn,
  port             => '80',
  docroot          => '/vagrant/wordpress/build',
  docroot_owner    => 'vagrant',
  docroot_group    => 'vagrant',
  override         => 'All',
  custom_fragment  => 'LogLevel warn rewrite:trace3'
}
apache::vhost { 'wordpress-ssl':
  servername       => $fqdn,
  port             => '443',
  docroot          => '/vagrant/wordpress/build',
  docroot_owner    => 'vagrant',
  docroot_group    => 'vagrant',
  ssl              => true,
  override         => 'All',
  custom_fragment  => 'LogLevel warn rewrite:trace3'
}
apache::fastcgi::server { 'php':
  host       => '127.0.0.1:9000',
  timeout    => 7200,
  file_type  => 'application/x-httpd-php'
}

class { 'mysql::server':
  root_password => 'wordpress'
}

mysql::db { ['wordpress', 'wordpress-tests']:
  ensure   => present,
  charset  => 'utf8',
  user     => 'wordpress',
  password => 'wordpress',
  host     => 'localhost',
  grant    => ['ALL'],
  require  => Class['mysql::server']
}
