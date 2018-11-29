# frozen_string_literal: true

module CwdsStore
  class Store < ActionDispatch::Session::AbstractStore
    USE_INDIFFERENT_ACCESS = defined?(ActiveSupport).freeze

    attr_reader :redis

    def initialize(app, options = {})
      super

      # works: host, port, namespace
      # doesn't work: expire_after
      @redis = Redis::Store.new(
        {
          host: options[:host],
          port: options[:port],
          db: 0,
          namespace: 'test-session',
          expire_after: 3.minutes
        }
      )

      # doesn't work at all
      @redis = Redis::Store.new(
        {
          servers: [
            {
              host: options[:host],
              port: options[:port],
              db: 0,
              namespace: 'test-session'
            }
          ],
          expire_after: 3.minutes
        }
      )
    end

    def get_session(env, session_id)
      session_data = @redis.get(session_id)
      session_id && session_data ? [session_id, session_data] : session_default_values
    end
    alias find_session get_session

    def session_default_values
      [generate_sid, USE_INDIFFERENT_ACCESS ? {}.with_indifferent_access : {}]
    end

    def set_session(env, session_id, session, options)
      @redis.set(session_id, session)
      session_id
    end
    alias write_session set_session

    def destroy_session(env, session_id, options)
      @redis.del(session_id)
      (options || {})[:drop] ? nil : generate_sid
    end
    alias delete_session destroy_session
  end
end
