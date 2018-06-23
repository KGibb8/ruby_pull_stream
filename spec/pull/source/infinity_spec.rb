# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Infinity do

  let(:source) { Pull::Infinity.new }
  let(:read) { source.() }

  describe "behaviour" do

    it "increments through the values when called" do
      10.times do |i|
        read.(false, -> (value) {
          expect(value).to eq(i)
        })
      end
    end
  end
end
