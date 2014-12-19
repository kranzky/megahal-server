require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module MegahalServer
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.logger = Hodel3000CompliantLogger.new(config.paths['log'].first)
    config.time_zone = 'UTC'
    config.after_initialize do
      ActiveRecord::Base.logger = nil
    end
  end
end
