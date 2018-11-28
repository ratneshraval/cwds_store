# frozen_string_literal: true

module CwdsStore
  class Store < ActionDispatch::Session::AbstractStore

    attr_reader :redis

    def initialize(app, options = {})
      super

      transformed_options = transform_options(options)
      # super(options_merge(incoming_options))

      @redis = Redis::Store.new transformed_options
    end

    def get_session(env, session_id)
      redis.get(session_id)
    end

    def set_session(env, session_id, session, options)
      redis.set(session_id, session)
    end

    def destroy_session(env, session_id, options)
      redis.del(session_id)
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
