
class { 'apache': }

if $::lsbdistcodename == 'precise' {
  class { 'apache::mod::version': }
}

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

include apache::mod::suphp

apache::mod { 'rewrite': }

apache::vhost { 'wordpress':
  servername       => $fqdn,
  port             => '80',
  docroot          => '/vagrant/wordpress/build',
  docroot_owner    => 'vagrant',
  docroot_group    => 'vagrant',
  suphp_addhandler => 'application/x-httpd-suphp',
  suphp_engine     => 'on',
  suphp_configpath => '/etc/php5/cgi',
  override         => 'All',
  custom_fragment  => @(APACHECONF)
    <IfVersion < 2.4>
      RewriteLogLevel 2
      RewriteLog /var/log/apache2/rewrite.log
    </IfVersion>
    <IfVersion >= 2.4>
      LogLevel warn rewrite:trace3
    </IfVersion>
    | APACHECONF
}
apache::vhost { 'wordpress-ssl':
  servername       => $fqdn,
  port             => '443',
  docroot          => '/vagrant/wordpress/build',
  docroot_owner    => 'vagrant',
  docroot_group    => 'vagrant',
  ssl              => true,
  suphp_addhandler => 'application/x-httpd-suphp',
  suphp_engine     => 'on',
  suphp_configpath => '/etc/php5/cgi',
  override         => 'All',
  custom_fragment  => @(APACHECONF)
    <IfVersion < 2.4>
      RewriteLogLevel 2
      RewriteLog /var/log/apache2/rewrite-ssl.log
    </IfVersion>
    <IfVersion >= 2.4>
      LogLevel warn rewrite:trace3
    </IfVersion>
    | APACHECONF
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
