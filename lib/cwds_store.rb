# frozen_string_literal: true

require 'cwds_store/version'
require 'redis/store'

module CwdsStore
  class << self < Redis::Store
    def initialize(options = {})
      super
    end
  end

  class Error < StandardError; end
end
