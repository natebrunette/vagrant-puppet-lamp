class php 
{
    $packages = [
        "php5", 
        "php5-cli", 
        "php5-mysql", 
        "php-pear", 
        "php5-dev", 
        "php-apc", 
        "php5-mcrypt", 
        "php5-gd", 
        "php5-curl",
        "libapache2-mod-php5"
    ]
    
    package 
    { 
        $packages:
            ensure  => latest,
            require => [Exec['apt-get update'], Package['python-software-properties']]
    }
  
    # exec 
    # { 
    #     "sed -i 's|#|//|' /etc/php5/cli/conf.d/mcrypt.ini":
  		#     require => Package['php5'],
    # }

    file 
    { 
        "/etc/php5/apache2/php.ini":
            ensure  => present,
            owner => root, group => root,
            source  => "/vagrant/puppet/templates/php.ini",
            require => [Package['php5'], Package['apache2']],
    }

    exec { "pear upgrade":
            command => "pear upgrade",
            require => [Package['php5-cli'], Package['php-pear']],
        }
        exec { "pear auto-discover":
            command => "pear config-set auto_discover 1 system",
            unless => "pear config-get auto_discover system | grep 1",
            require => Exec['pear upgrade'],
        }
        exec { "pear-phpunit":
            command => "pear install --alldeps pear.phpunit.de/PHPUnit",
            unless => "pear info pear.phpunit.de/PHPUnit",
            require => Exec['pear auto-discover'],
        }
        exec { "pear-phpcpd":
            command => "pear install pear.phpunit.de/phpcpd",
            unless => "pear info pear.phpunit.de/phpcpd",
            require => Exec['pear auto-discover'],
        }
        exec { "pear-phploc":
            command => "pear install pear.phpunit.de/phploc",
            unless => "pear info pear.phpunit.de/phploc",
            require => Exec['pear auto-discover'],
        }
        exec { "pear-phpmd":
            command => "pear install --alldeps pear.phpmd.org/PHP_PMD",
            unless => "pear info pear.phpmd.org/PHP_PMD",
            require => Exec['pear auto-discover'],
        }
        exec { "pear-phpdoc":
            command => "pear install pear.phpdoc.org/phpDocumentor-alpha",
            unless => "pear info pear.phpdoc.org/phpDocumentor-alpha",
            require => Exec['pear auto-discover'],
        }
        exec { "pear-phing":
            command => "pear install pear.phing.info/phing",
            unless => "pear info pear.phing.info/phing",
            require => Exec['pear auto-discover'],
        }


    
}
