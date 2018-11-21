# frozen_string_literal: true

require 'cwds_store/version'
require 'redis/store'

class CwdsStore < Redis::Store
  def initialize(options = {})
    super
    puts 'initializing'
  end
end

#   class Error < StandardError; end
# end
