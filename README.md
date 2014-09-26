# DevDump

Provides Rake tasks to dump a database to an encrypted file on a remote server, download the file, and restore a local DB from the file.

## Installation

Add this line to your application's Gemfile:

    gem 'dev_dump'

And then execute:

    $ bundle

This depends on `gpg`. Install it on OS X with `brew install gpg`.

## Usage

    rake dev_dump:dump # run from the app root on production. dump postgres DB to a file. supply a passphrase for gpg encryption.
    rake dev_dump:download_file[/path/to/file/on/prod] # run from developer machine, with a file path in mind
    rake dev_dump:load[/path/to/local/file] # run after the dump file is downloaded

## Configuration

Configuration can be provided with a Rails initializer as a configuration file, following [this approach](http://robots.thoughtbot.com/mygem-configure-block).

    DevDump.configure do |config|
      config.backups_path = "/tmp/some_dir"
      config.ssh_user = "user"
      config.ssh_host = "host.server.com"
    end
