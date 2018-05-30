# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Values do
  let(:values) { Pull::Values.new([1, 2, 3, 4, 5]) }

  describe "#initialize" do
    it "throws an error unless passed an array" do
      expect{ Pull::Values.new("woof") }.to raise_error TypeError
    end

    it "takes an abort callback" do
      callback = values.instance_variable_get("@on_abort")
      expect(callback).to be_a_kind_of(Proc)
    end
  end
end
