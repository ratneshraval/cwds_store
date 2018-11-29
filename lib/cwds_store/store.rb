# frozen_string_literal: true

module CwdsStore
  class Store < ActionDispatch::Session::RedisStore
    def initialize(app, options = {})
      merged_options = options_merge(transform_options(options))
      super(app, merged_options)
    end

    def transform_options(options)
      {
        servers: [
          {
            host: options[:host],
            port: options[:port],
            db: 0,
            namespace: 'cares:session'
          }
        ]
      } unless options.nil?
    end

    def options_merge(options)
      base_options = {
        # servers: [],
        expire_after: 4.hours
      }
      base_options.merge!(options) unless options.nil?
      base_options
    end
  end
end
