# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Collect do
  describe "behaviour" do
    let(:callback) { -> (values) { values } }
    let(:values) { [1, 2, 3, 4, 5] }
    let(:source) { Pull::Values.new(values) }
    let(:sink) { Pull::Collect.new(callback) }

    it "collects each item from the stream and runs the callback when all are present" do
      expect(callback).to receive(:call) do |args|
        expect(args).to eq values
      end

      sink.(source.())
    end
  end
end
