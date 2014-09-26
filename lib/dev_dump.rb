require "dev_dump/version"
require "dev_dump/railtie" if defined?(Rails)

module DevDump
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :rails_db_config, :backups_path, :ssh_user, :ssh_host

    def initialize
      self.rails_db_config = YAML.load_file(File.join(Dir.getwd, 'config', 'database.yml'))[Rails.env]
      self.backups_path = "/tmp/backups/"
      self.ssh_user = nil
      self.ssh_host = nil
    end
  end
end
