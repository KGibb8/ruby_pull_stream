# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Map do
  let(:squared) { -> (value) { value ** 2 } }
  let(:source) { Pull::Values.new([1, 2, 3, 4, 5]) }
  let(:through) { Pull::Map.new(squared) }

  describe "behaviour" do
    it "responds to call" do
      expect(through).to respond_to(:call)
    end

    it "returns a lambda" do
      expect(through.(source.())).to be_a_kind_of Proc
    end

    it "performs the map when required by a sink" do
      callback = -> (values) {
        expect(values).to eq [1, 4, 9, 16, 25]
        expect(values.sum).to eq 55
      }

      sink = Pull::Collect.new(callback)
      sink.(through.(source.()))
    end
  end

end
