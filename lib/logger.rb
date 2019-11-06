# frozen_string_literal: true

require 'logger'

module Log
  def self.current
    @current ||= Logger.new(STDOUT)
  end
end
