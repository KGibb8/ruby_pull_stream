# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Filter do
  let(:stream) { [1, 2, 3, 4, 5] }
  let(:source) { Pull::Values.new(stream) }

  describe 'behaviour' do
    it "filters values that return false from the callback" do
      sink = Pull::Collect.new do |values|
        expect(values).to be_empty
      end

      through = Pull::Filter.new { |value| false }
      sink.(through.(source.()))
    end

    it "keeps values that return true from the callback" do
      sink = Pull::Collect.new do |values|
        expect(values).to eq [1, 2, 3, 4, 5]
      end

      through = Pull::Filter.new { |value| true }
      sink.(through.(source.()))
    end
  end
end
