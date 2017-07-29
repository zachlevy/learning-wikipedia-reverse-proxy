require_relative 'boot'

require 'rails/all'
require_relative "response_modifier"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WebReverseProxy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.use ResponseModifier

    # reverse proxy
    config.middleware.use Rack::ReverseProxy do
      reverse_proxy_options preserve_host: true
      reverse_proxy /^(.*)$/, "#{ENV["PROXY_DOMAIN"]}$1"
    end
  end
end
