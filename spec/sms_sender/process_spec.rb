require 'spec_helper'

module SmsSender
  RSpec.describe Process do
    describe '#initialize' do
      let(:item) { Security.new }
      let(:changes) { Hash.new }

      it 'correctly sets instance variables' do
        changeset = described_class.new(item, changes)

        expect(changeset.instance_variable_get(:@item)).to eql(item)
        expect(changeset.instance_variable_get(:@changes)).to eql(changes)
      end

      it 'raises `ArgumentError` for `nil` changes' do
        expect { described_class.new(item, nil) }.to raise_error(ArgumentError)
      end

      it 'raises `ArgumentError` for changes with odd number of arguments that are not `Hash`' do
        expect { described_class.new(item, 1) }.to raise_error(ArgumentError)
      end
    end
  end
end
