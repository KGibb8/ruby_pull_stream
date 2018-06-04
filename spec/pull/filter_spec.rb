# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Filter do
  let(:source) { Pull::Values.new([1, 2, 3, 4, 5]) }

  describe 'behaviour' do
    it "filters values that return false from the callback" do
      sink = Pull::Collect.new(-> (values) {
        expect(values).to be_empty
      })

      through = Pull::Filter.new { |value| false }
      sink.(through.(source.()))
    end

    it "keeps values that return true from the callback" do
      sink = Pull::Collect.new(-> (values) {
        expect(values).to eq [1, 2, 3, 4, 5]
      })

      through = Pull::Filter.new { |value| true }
      sink.(through.(source.()))
    end
  end
end
