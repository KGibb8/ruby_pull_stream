require "spec_helper"

RSpec.describe Pull do
  it "has a version number" do
    expect(Pull::VERSION).not_to be "0.1.0"
  end

  context "pull" do
    include Pull

    it "responds to pull" do
      respond_to?(:pull)
    end

    it "returns a helper instance when provided no arguments" do
      expect(pull).to be_an_instance_of Pull::Helper
    end

    it "returns a stream instance when provided arguments" do
      stream = pull(
        pull.values([1, 2, 3, 4]),
        pull.drain(-> (msg) { puts msg })
      )
      expect(stream).to be_an_instance_of Pull::Stream
    end
  end
end
