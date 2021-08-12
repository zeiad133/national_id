require_relative 'boot'

require 'rails' # Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
# require 'active_record/railtie' # require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine' # require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EgyptianNationalId
  class Application < Rails::Application # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0 #
    config.api_only = true # Don't generate system test files.
    config.generators.system_tests = nil
    # config.active_record.index_nested_attribute_errors = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_url_options = { host: ENV.fetch('DOMAIN_URL') }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.smtp_settings = {
      address: ENV['KOTTENORA_MAILGUN_ADDRESS'],
      port: ENV['KOTTENORA_MAILGUN_PORT'],
      domain: ENV['KOTTENORA_MAILGUN_DOMAIN'],
      user_name: ENV['KOTTENORA_MAILGUN_USER'],
      password: ENV['KOTTENORA_MAILGUN_PASS'],
      authentication: 'plain',
      enable_starttls_auto: true
    }

    # setup active job to use sidekiq as the default queue adapter
    config.active_job.queue_adapter = :inline
    # config.active_job.queue_name_prefix = "KOTTENORA#{Rails.env}"
  end
end
