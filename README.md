# Custom PHP ini

A Chassis extension that allows you to overwrite the default `php.ini` configuration values so you can tailor your Chassis box to match your server requirements.

## Usage

1. Add your custom [php.ini](http://php.net/manual/en/ini.core.php) values to `modules/phpini/templates.custom.ini.erb`
2. Run `vagrant provision`
3. To check the values have been applied you can browse to [http://vagrant.local/phpinfo.php](http://vagrant.local/phpinfo.php).

## Roadmap

1. Add support for loading a custom ini file that's been version controlled in the `content` directory.
