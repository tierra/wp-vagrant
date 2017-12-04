# WordPress Vagrant Boxes

While we're fans of the popular [VVV](https://github.com/10up/varying-vagrant-vagrants)
project, this [Vagrant](http://vagrantup.com) configuration takes a different approach.
We like to think that VVV is great for up-to-date development tools, working on plugins
and themes, and building entirely new websites. However, this configuration was built
for the purpose of testing and debugging mostly WordPress core, and ensuring
compatibility with older (but still supported) server configurations.

This configuration also doesn't make any assumptions about your preferred development
workflow. It does not checkout or install WordPress at all. It's up to you if you
would like to unpack and install a ZIP, checkout from SVN, or clone from git. However,
the web server is preconfigured to look for WordPress in a specific location.

## Configurations Provided

***wordpress-php53***

* Ubuntu 12.04 (precise)
* Apache 2.2.22 (suPHP, port 80 and 443)
* PHP 5.3.10
* PHP Extensions: curl, gd, imagick, mcrypt, mysql, xdebug
* PHPUnit 4.8.27
* MySQL 5.5.50
* Subversion 1.6.17, Git 1.7.9.5
* Node.js 6.4.0, Grunt

***wordpress-php54***

* Debian 7.8 (wheezy)
* Apache 2.2.22 (suPHP, port 80 and 443)
* PHP 5.4.45
* PHP Extensions: curl, gd, imagick, mcrypt, mysql, xdebug
* PHPUnit 4.8.27
* MySQL 5.5.50
* Subversion 1.6.17, Git 1.7.10.4
* Node.js 6.4.0, Grunt

***wordpress-php55***

* Ubuntu 14.04 (trusty)
* Apache 2.4.7 (suPHP, port 80 and 443)
* PHP 5.5.9
* PHP Extensions: curl, gd, imagick, mcrypt, mysql, xdebug
* PHPUnit 4.8.27
* MySQL 5.5.50
* Subversion 1.8.8, Git 1.9.1
* Node.js 6.5.0, Grunt

## Getting Started

1. Install both [VirtualBox](https://www.virtualbox.org/) and
   [Vagrant](http://www.vagrantup.com/).
2. Clone this repository to a convenient location for your development:
    * `git clone https://github.com/tierra/wp-vagrant.git`
    * `cd wp-vagrant`
3. Check out (or clone) the develop repo to the `wordpress` folder:
    * `svn checkout https://develop.svn.wordpress.org/trunk wordpress` or
    * `git clone git://develop.git.wordpress.org/ wordpress`
4. Add the following to your hosts file:
    * `192.168.167.10 wordpress-php53.local`
    * `192.168.167.11 wordpress-php54.local`
    * `192.168.167.12 wordpress-php55.local`
5. Start Vagrant: `vagrant up [box]`
    * Without naming a box, just the `wordpress-php55` box will be started.
      Specify `wordpress-php53`, or `wordpress-php54`, to start up instead.

Note that Apache is configured to point to the `wordpress/build` directory,
so you need to remember to run `grunt` from the WordPress directory after
checking out the code. Optionally, you could also just install WordPress
normally inside the `wordpress/build` directory without using the develop
repository. All boxes are pre-configured with Node.js and Grunt, so if you
don't have these tools installed locally, you can just SSH into the box, and
run the following:

```
cd /vagrant/wordpress && npm install && grunt
```

With any of the boxes started, you can reach them at these locations:

* http://wordpress-php53.local/
* http://wordpress-php54.local/
* http://wordpress-php55.local/

## MySQL Configuration

The MySQL root password is "wordpress", and all boxes
come with two pre-configured databases:

* `wordpress` (this is meant for a regular installation)
* `wordpress-tests` (this is meant for use with PHPUnit tests)

A single account with rights to all databases for convenience:

* Username: `wordpress`
* Password: `wordpress`
