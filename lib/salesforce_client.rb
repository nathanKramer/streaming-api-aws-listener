# frozen_string_literal: true

require 'restforce'
require 'faye'

require_relative './logger'

module SalesforceClient
  SF_AUTH = {
    username: ENV.fetch('USERNAME'),
    client_id: ENV.fetch('CLIENT_ID'),
    client_secret: ENV.fetch('CLIENT_SECRET'),
    api_version: ENV.fetch('API_VERSION'),
    jwt_key: ENV.fetch('JWT_KEY')
  }.freeze

  def self.new(options = SF_AUTH)
    Restforce.new(options).tap do |client|
      if ENV['DEBUG_STREAMING'] == 'true'
        Restforce.configure { |config| config.logger = Log.current }
        Faye.logger = Log.current
      end

      client.authenticate!
      Log.current.info "Connected to #{client.options[:host]} " \
                  "as #{client.options[:username]}"
    end
  end
end
