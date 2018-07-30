# Custom PHP ini

A Chassis extension that allows you to overwrite the default `php.ini` configuration values so you can tailor your Chassis box to match your server requirements.

## Usage
1. Add a `custom.ini` file inside your `content` directory with your [custom configuration](http://php.net/manual/en/ini.core.php). e.g. `memory_limit = 512M`
2. Commit that to your Git repository.
3. Run `vagrant provision`.
4. To check the values have been applied you can browse to [http://vagrant.local/phpinfo.php](http://vagrant.local/phpinfo.php).
