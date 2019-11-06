# frozen_string_literal: true

require './lib/logger'
require './lib/salesforce_client'
require './lib/streaming_api_listener'

class LambdaHandler
  def initialize(event:, context:)
    @event = event
    @context = context
  end

  def start_stream
    Log.current.info(
      "Starting Stream on channels: #{streaming_channels}"
    )
    listener.listen(
      channel: streaming_channels,
      &method(:process_message)
    )
  end

  private

  def process_message(channel:, message:)
    Log.current.info(
      "Processing message for #{channel}\n#{message.inspect}"
    )
  end

  def listener
    @listener ||= StreamingApiListener.new
  end

  def streaming_channels
    @streaming_channels ||= ENV.fetch('COMMA_SEPARATED_CHANNELS')
  end
end
