# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pull::Sink do
   describe "methods" do
     describe "#initialize" do
       context "without an object that responds to #call" do
         it "raises an error" do
           expect { Pull::Sink.new("should raise an error") }.to raise_error TypeError
         end
       end

       context "with an object that responds to #call" do
         it "just works" do
           callback = -> (value) { "just works" }
           expect(Pull::Sink.new(callback)).to be_an_instance_of Pull::Sink
         end
       end
     end

     describe "#call" do
       context "without an object that responds to #call" do
         let(:sink) { Pull::Sink.new("should raise an error") }

         it "raises an error" do
           expect { sink.("thing") }.to raise_error TypeError
         end
       end
     end
   end
end
