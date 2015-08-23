
class { 'apache': }

package { [
  'build-essential',
  'curl',
  'git',
  'php5-cli',
  'php5-curl',
  'php5-gd',
  'php5-imagick',
  'php5-mcrypt',
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

include apache::mod::suphp

apache::mod { 'rewrite': }

apache::vhost { 'wordpress':
  servername       => $::fqdn,
  port             => '80',
  docroot          => '/vagrant/wordpress/build',
  docroot_owner    => 'vagrant',
  docroot_group    => 'vagrant',
  suphp_addhandler => 'application/x-httpd-suphp',
  suphp_engine     => 'on',
  suphp_configpath => '/etc/php5/cgi',
  override         => 'All',
  custom_fragment  => 'RewriteLogLevel 2
                       RewriteLog /var/log/apache2/rewrite.log'
}

apache::vhost { 'wordpress-ssl':
  servername       => $::fqdn,
  port             => '443',
  docroot          => '/vagrant/wordpress/build',
  docroot_owner    => 'vagrant',
  docroot_group    => 'vagrant',
  ssl              => true,
  suphp_addhandler => 'application/x-httpd-suphp',
  suphp_engine     => 'on',
  suphp_configpath => '/etc/php5/cgi',
  override         => 'All',
  custom_fragment  => 'RewriteLogLevel 2
                       RewriteLog /var/log/apache2/rewrite-ssl.log'
}

class { 'mysql::server':
  root_password => 'wordpress'
}

class { 'mysql::bindings':
  php_enable => 'true',
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
