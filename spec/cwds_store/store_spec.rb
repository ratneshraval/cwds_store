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
      expect(cwds_store_object.class.superclass).to eql ActionDispatch::Session::AbstractStore
    end
  end
end
