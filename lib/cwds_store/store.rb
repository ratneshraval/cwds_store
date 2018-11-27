# frozen_string_literal: true

module CwdsStore
  class Store < Redis::Store
    def initialize(options = {})
      incoming_options = transform_options(options)
      super(options_merge(incoming_options))
    end

    def transform_options(options)
      {
        servers: [
          {
            host: options[:host],
            port: options[:port],
            db: 0,
            namespace: ''
          }
        ]
      } unless options.nil?
    end

    def options_merge(options)
      base_options = {
        servers: [
          {
            host: 'localhost',
            port: 6379,
            db: 0,
            namespace: ''
          }
        ],
        expire_after: 60
      }
      base_options.merge!(options) unless options.nil?
      base_options
    end
  end
end
