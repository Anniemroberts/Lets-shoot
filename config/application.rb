require_relative 'boot'

require "rails"
require "figaro"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Rails.env.facebook_app_id = Figaro.env.facebook_app_id
# Rails.env.facebook_app_secret = Figaro.env.facebook_app_secret

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LetsShoot
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

# if Rails.env == 'development' || Rails.env == 'test'
#   Rails.application.config.middleware.use OmniAuth::Builder do
#     provider :facebook, '1760540804257696', '267cf8c8fe81a0ef6743a54dc7de1fa7'
#   end
# else
#   # Production
#   Rails.application.config.middleware.use OmniAuth::Builder do
#     provider :facebook, '1760540804257696', '267cf8c8fe81a0ef6743a54dc7de1fa7'
#   end
# end
