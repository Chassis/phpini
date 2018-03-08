# Setup our php ini class
class phpini (
	$config,
	$path = '/vagrant/extensions/phpini',
) {

	if ( ! empty( $config[disabled_extensions] ) and 'chassis/phpini' in $config[disabled_extensions] ) {
		$file = absent
	} else {
		$file = present
	}

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

	exec { 'copy_ini':
		path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		command => "cp /vagrant/content/custom.ini /etc/${php_dir}/fpm/conf.d/custom.ini",
		onlyif  => 'test -f /vagrant/content/custom.ini'
	}

	file { "/etc/${php_dir}/fpm/conf.d/custom.ini":
		ensure  => $file,
		content => template('phpini/custom.ini.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		require => Package["${php_package}-fpm"],
		notify  => Service["${php_package}-fpm"],
		replace => true
	}
}
