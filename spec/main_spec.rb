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

    describe '#my_each_with_index' do
        it 'passes each element and its index through a code block' do
            hash = Hash.new
            %w[apple banana cherry].my_each_with_index {|e, i| hash[i] = e}
            expect(hash).to eql({0 => 'apple', 1 => 'banana', 2 => 'cherry'})
        end
    end

    describe '#each' do
        it 'passes each element through a code block' do
            array = Array.new
            %w[apple banana cherry].my_each {|e| array.push(e)}
            expect(array).to eql(['apple', 'banana', 'cherry'])
        end
    end
end



