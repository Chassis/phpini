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

	$content_dir = $config[mapped_paths][content]

	exec { 'copy_fpm_ini':
		path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		command => "cp -f ${content_dir}/custom.ini /etc/${php_dir}/fpm/conf.d/custom.ini",
		onlyif  => "test -f ${content_dir}/custom.ini",
		require => Package["${php_package}-fpm"],
		notify  => Service["${php_package}-fpm"]
	}

	exec { 'copy_cli_ini':
		path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		command => "cp -f ${content_dir}/custom.ini /etc/${php_dir}/cli/conf.d/custom.ini",
		onlyif  => "test -f ${content_dir}/custom.ini",
		require => Package["${php_package}-fpm"],
		notify  => Service["${php_package}-fpm"]
	}
}
