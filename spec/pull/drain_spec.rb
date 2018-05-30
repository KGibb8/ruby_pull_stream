 require "spec_helper"

 RSpec.describe Pull::Drain do
   describe "behaviour" do
     let(:callback) { -> (value) {  } }
     let(:source) { Pull::Values.new([1, 2, 3, 4, 5]) }
     let(:sink) { Pull::Drain.new(callback) }

     it "passes the source value to the callback until exhausted, then exits" do
       expect(callback).to receive(:call).exactly(5).times
       sink.(source.())
     end
   end
 end
