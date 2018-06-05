 require "spec_helper"

 RSpec.describe Pull::Drain do
   describe "behaviour" do
     let(:stream) { [1, 2, 3, 4, 5] }
     let(:source) { Pull::Values.new(stream) }

     it "passes the source value to the callback until exhausted, then exits" do
       sink = Pull::Drain.new do |value|
         expect(stream[value - 1]).to eq value
       end

       sink.(source.())
     end
   end
 end
