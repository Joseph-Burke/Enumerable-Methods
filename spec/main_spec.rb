require './main'

describe Enumerable do
    describe '#my_select' do
        it "returns an array of items which the code block passes as true" do
            expect([1, 2, 3].my_select {|e| e.even?}).to eql([2])
        end
    end

    describe '#my_all' do
        it "returns true if all items return true when passed through the code block" do
            expect([1, 2, 3].my_all? { |e| e < 5 }).to eql(true)
        end
    end

end





