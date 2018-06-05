# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Collect do
  describe "behaviour" do
    let(:stream) { [1, 2, 3, 4, 5] }
    it "collects each item from the stream and runs the callback when all are present" do
      source = Pull::Values.new(stream)

      sink = Pull::Collect.new do |values|
        expect(values).to eq stream
      end

      sink.(source.())
    end
  end
end
