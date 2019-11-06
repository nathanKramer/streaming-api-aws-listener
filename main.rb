# frozen_string_literal: true

require 'dotenv/load' if ENV['ENV'] != 'production'
require 'eventmachine'

require './lambda_handler'
require './lib/logger'

$stdout.sync = true

def lambda_handler(event:, context:)
  handler = LambdaHandler.new(
    event: event,
    context: context
  )
  EM.run { handler.start_stream }
rescue StandardError => e
  Log.current.error("Fatal error: #{e}")
  raise e
end

lambda_handler(event: nil, context: nil)
