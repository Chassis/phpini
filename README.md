# Custom PHP ini

A Chassis extension that allows you to overwrite the default `php.ini` configuration values so you can tailor your Chassis box to match your server requirements.

## Usage

1. Add your custom [php.ini](http://php.net/manual/en/ini.core.php) values to `modules/phpini/templates/custom.ini.erb`
2. Run `vagrant provision`
3. To check the values have been applied you can browse to [http://vagrant.local/phpinfo.php](http://vagrant.local/phpinfo.php).

## Adding your custom ini configuration to version control.
1. Add a `custom.ini` file inside your `content` directory.
2. Commit that to your Git repository.
3. Run `vagrant provision`. If your `content` folder contains a `custom.ini` file it will take precedence over any edits to `modules/phpini/templates/custom.ini.erb`. 
