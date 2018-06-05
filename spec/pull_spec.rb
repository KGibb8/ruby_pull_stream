# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull do
  it "has a version number" do
    expect(Pull::VERSION).not_to be "0.1.0"
  end

  describe "#pull" do
    include Pull

    let(:values) { [1, 2, 3, 4, 5] }

    it "responds to pull" do
      respond_to?(:pull)
    end

    it "returns a helper instance when provided no arguments" do
      expect(pull).to be_an_instance_of Pull::Helper
    end

    it "applies a sink to a through to a source" do
      pull(
        pull.values(values),
        pull.map { |value| value ** 2 },
        pull.collect do |values|
          expect(values.sum).to eq 55
        end
      )
    end

    it "applies multiple throughs before a sink" do
      pull(
        pull.values(values),
        pull.filter { |value| value != 2 },
        pull.map { |value| value ** 2 },
        pull.take(2),
        pull.collect do |values|
          expect(values.sum).to eq 10
        end
      )
    end
  end
end
