# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Take do
  let(:source) { Pull::Values.new([1, 2, 3, 4, 5]) }
  let(:through) { Pull::Take.new(2) }

  describe "behaviour" do
    it "responds to call" do
      expect(through).to respond_to(:call)
    end

    it "returns a lambda" do
      expect(through.(source.())).to be_a_kind_of Proc
    end

    it "breaks after take value" do
      sink = Pull::Collect.new do |values|
        expect(values).to eq [1, 2]
        expect(values.sum).to eq 3
      end

      sink.(through.(source.()))
    end
  end

end
