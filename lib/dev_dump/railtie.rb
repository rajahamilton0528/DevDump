require 'dev_dump'
require 'rails'
require 'rails/railtie'

module DevDump
  class Railtie < Rails::Railtie
    rake_tasks do
      # NOTE: seems like it should be able to be called from config.after_initialize block, but that didn't work
      require Rails.root.join('config/initializers/dev_dump.rb')

      load 'tasks/dev_dump.rake'
    end
  end
end
