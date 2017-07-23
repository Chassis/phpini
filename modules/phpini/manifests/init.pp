class phpini (
	$config,
	$path = '/vagrant/extensions/phpini',
) {
	$version = $config[php]

	if $version =~ /^(\d+)\.(\d+)$/ {
		$package_version = "${version}.*"
		$short_ver = $version
	}
	else {
		$package_version = "${version}*"
		$short_ver = regsubst($version, '^(\d+\.\d+)\.\d+$', '\1')
	}

	if versioncmp( $version, '5.4') <= 0 {
		$php_package = 'php5'
		$php_dir = 'php5'
	}
	else {
		$php_package = "php${short_ver}"
		$php_dir = "php/${short_ver}"
	}

	file { "/etc/${php_dir}/fpm/conf.d/custom.ini":
    		ensure  => 'present',
    		content => template('phpini/custom.ini.erb'),
    		owner   => 'root',
    		group   => 'root',
    		mode    => '0644',
    		require => Package["${php_package}-fpm"],
    		notify  => Service["${php_package}-fpm"]
    	}
}
