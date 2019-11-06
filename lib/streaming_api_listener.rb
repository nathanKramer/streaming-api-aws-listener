# frozen_string_literal: true

class StreamingApiListener
  def listen(channel:, &block)
    client.subscription(channel, replay: -2) do |message|
      block.call(channel: channel, message: message)
    end
  end

  private

  def client
    @client ||= SalesforceClient.new
  end
end
