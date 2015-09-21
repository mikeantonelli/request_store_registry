require 'spec_helper'
require 'request_store_registry'

class TestRequestStoreRegistry
  extend RequestStoreRegistry
  attr_accessor :foo
end

RSpec.describe RequestStoreRegistry do
  describe '#extended' do
    it 'extends ActiveSupport::PerThreadRegistry' do
      expect(TestRequestStoreRegistry.is_a?(ActiveSupport::PerThreadRegistry)).to be_truthy
    end
  end

  describe '#instance' do
    it 'utilizes RequestStore.store' do
      expect(TestRequestStoreRegistry.instance).to eq(Thread.current[:request_store][TestRequestStoreRegistry.name])
    end
    it 'always returns the same instance' do
      expect(TestRequestStoreRegistry.instance).to eq(TestRequestStoreRegistry.instance)
    end
  end

  describe 'storage' do
    it 'saves attributes to Thread.current' do
      TestRequestStoreRegistry.foo = 'bar'
      expect(Thread.current[:request_store][TestRequestStoreRegistry.name].foo).to eq('bar')
    end
  end
end