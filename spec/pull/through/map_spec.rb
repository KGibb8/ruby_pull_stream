# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Map do
  let(:values) { Pull::Values.new([1, 2, 3, 4, 5]) }
  let(:mapper) { Pull::Map.new { |value| value ** 2 } }

  describe "behaviour" do
    it "responds to call" do
      expect(mapper).to respond_to(:call)
    end

    it "returns a lambda" do
      expect(mapper.(values.())).to be_a_kind_of Proc
    end

    it "performs the map when required by a sink" do
      sink = Pull::Collect.new do |values|
        expect(values).to eq [1, 4, 9, 16, 25]
        expect(values.sum).to eq 55
      end

      sink.(mapper.(values.()))
    end
  end

end
