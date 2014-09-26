require "yaml"
require "erb"
require "dev_dump"

namespace :dev_dump do
  desc "dump the database to a zipped file"
  task :dump => :environment do
    raise "gpg is required." unless `which gpg`
    raise "Ruby on Rails is required." unless defined?(Rails)
    raise "pg_dump is required." unless `which pg_dump`

    if db_config = DevDump.configuration.rails_db_config
      filename = "#{db_config['database']}.dump.#{Time.now.to_i}.sql"
      Dir.mkdir(DevDump.configuration.backups_path) unless File.exists?(DevDump.configuration.backups_path)
      file = "#{DevDump.configuration.backups_path}#{filename}"
      db_user = ERB.new(db_config['username']).result

      `pg_dump --clean --no-owner --no-privileges -U#{db_user} #{db_config['database']} | gzip > #{file}.gz`
      if File.exists?("#{file}.gz")
        `gpg -c #{file}.gz`
        `rm #{file}.gz`
        puts "wrote file: #{file}.gz.gpg"
      end
    end
  end

  desc "download dump file"
  task :download_file, [:remote_path] do |t, args|
    if args && args[:remote_path]
      puts "downloading file #{args[:remote_path]}"
      `scp #{DevDump.configuration.ssh_user}@#{DevDump.configuration.ssh_host}:#{args[:remote_path]} #{args[:remote_path]}`
      puts "done."
    end
  end

  desc "load the database from a zipped file"
  task :load, [:filepath] do |t, args|
    raise "gpg is required." unless `which gpg`
    raise "gunzip is required." unless `which gunzip`
    raise "psql is required." unless `which psql`

    file = if args.present? && File.exists?(args[:filepath])
      args[:filepath]
    else
      `ls -tr #{DevDump.configuration.backups_path} | tail -n1`.chomp
    end
    if file.empty?
      puts "no backups found"
    else
      puts "restoring from file: #{file}"
      if db_config = DevDump.configuration.rails_db_config
        db_user = ERB.new(db_config['username']).result
        gzipped_file = file.gsub(/\.gpg/, '')
        puts "gzipped file path: #{gzipped_file}"

        `gpg #{file}`
        if File.exists?(gzipped_file)
          `gunzip -c #{gzipped_file} | psql -U #{db_user} -d #{db_config['database']}`
        end
        puts "...done."
      end
    end
  end
end
