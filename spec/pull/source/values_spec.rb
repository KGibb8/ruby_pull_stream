# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Values do

  let(:bird_calls) { ["tweet", "squawk", "bk-aaap", "meep meep"]  }
  let(:source) { Pull::Values.new(bird_calls) }
  let(:read) { source.() }

  it "returns a lambda/proc when called" do
    expect(read).to be_a_kind_of Proc
  end

  describe "behaviour when called" do
    class HasACall
      def call(value)
        puts "I am a bird and I go #{value}"
        value
      end
    end

    let(:being_called) { HasACall.new }

    it "increments through the values when called" do
      read.(false, -> (value) {
        expect(value).to eq "tweet"
      })

      read.(false, -> (value) {
        expect(value).to eq "squawk"
      })
    end

    it "returns when all values have been passed" do
      bird_calls.count.times do
        read.(false, being_called)
      end

      last_call = read.(false, being_called)
      expect(last_call).to be_falsey
    end
  end
end
