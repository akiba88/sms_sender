require 'spec_helper'
require 'byebug'

module SmsSender
  RSpec.describe Config do
    describe '.instance' do
      it 'returns the singleton instance' do
        expect { described_class.instance }.to_not raise_error
      end
    end

    describe '.new' do
      it "raises 'NoMethodError'" do
        expect { described_class.new }.to raise_error(NoMethodError)
      end
    end

    describe '#options=' do
      it 'include available channel' do
        available_channels = SmsSender.config.available_channels
        options = { main: { a: 1, b: 2 } }

        described_class.instance.options = options

        described_class.instance.options.keys.each do |channel|
          expect(available_channels).to include(channel)
        end
      end
    end
  end
end