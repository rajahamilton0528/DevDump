# DevDump

Provides Rake tasks to dump and restore a PostgreSQL database via an encrypted file, for Ruby on Rails applications.

## Installation

    gem 'dev_dump'

And then execute:

    $ bundle

This depends on `gpg`, `gunzip` and Ruby on Rails. Install `gpg` on OS X with `brew install gpg`.

## Configuration

Add `config/initializers/dev_dump.rb` overriding any of the values below.

    DevDump.configure do |config|
      config.backups_path = "/tmp/some_dir"
      config.ssh_user = "user"
      config.ssh_host = "host.server.com"
    end

## Tasks

Run this task from the app root on production. This dumps the database to an encrypted file. You will be prompted for a passphrase used for gpg encryption.

    rake dev_dump:dump

Run this task on the local machine. This was tested in a bash shell.

    rake dev_dump:download_file[/path/to/file/on/prod]

Run this task on the local machine after the file is downloaded, using the same path. You will be prompted for the passphrase you entered above.

    rake dev_dump:load[/path/to/local/file] # run after the dump file is downloaded

