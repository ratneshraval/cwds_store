# frozen_string_literal: true

require 'spec_helper'
require 'redis-store'

module CwdsStore
  RSpec.describe Store do
    it 'has a version number' do
      expect(CwdsStore::VERSION).not_to be nil
    end

    it 'parent class is ActionDispatch::Session::AbstractStore' do
      cwds_store_object = Store.new({})
      expect(cwds_store_object.class.superclass).to eql ActionDispatch::Session::RedisStore
    end

    it 'transform_options with nil' do
      cwds_store_object = Store.new({})
      expect(cwds_store_object.transform_options(nil)).to eql nil
    end

    it 'transform_options with hash' do
      cwds_store_object = Store.new({})

      expected_output = {
        servers: [
          {
            host: 'xyz',
            port: 9300,
            db: 0,
            namespace: 'cares:session'
          }
        ]
      }

      expect(
        cwds_store_object.transform_options(
          host: 'xyz',
          port: 9300
        )
      ).to eql expected_output
    end

    it 'options merging with nil' do
      cwds_store_object = Store.new({})
      output = cwds_store_object.options_merge(nil)

      expected_output = {
        expire_after: 4.hours
      }

      expect(output).to eql expected_output
    end

    it 'options merging verification' do
      cwds_store_object = Store.new({})
      output = cwds_store_object.options_merge(expire_after: 30)

      expected_output = {
        expire_after: 30
      }

      expect(output).to eql expected_output
    end

    it 'options_merge with transformed values verification' do
      cwds_store_object = Store.new({})
      output = cwds_store_object.options_merge(
        cwds_store_object.transform_options(
          host: 'xyz',
          port: 9300
        )
      )

      expected_output = {
        servers: [
          {
            host: 'xyz',
            port: 9300,
            db: 0,
            namespace: 'cares:session'
          }
        ],
        expire_after: 4.hours
      }

      expect(output).to eql expected_output
    end
  end
end
