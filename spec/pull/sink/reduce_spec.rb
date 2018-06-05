# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Reduce do
  describe "behaviour" do
    let(:stream) { [1, 2, 3, 4, 5] }
    it "reduces each item from the stream into an accumulator" do
      source = Pull::Values.new(stream)

      sink = Pull::Reduce.new(0) do |sum, value|
        sum += value
        expect(stream[0..value-1].sum).to eq sum
        sum
      end

      sink.(source.())
    end
  end
end
