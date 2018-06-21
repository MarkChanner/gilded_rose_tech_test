require 'item'
require 'normal_item'

describe NormalItem do

  describe "#update" do
      it "does not change the name" do
        item = NormalItem.new("foo", 0, 0)
        expect(item.name).to eq "foo"
      end

      it "subtracts 1 from quality" do
        item1 = NormalItem.new("foo", 8, 1)
        item2 = NormalItem.new("foo", 0, 1)
        item1.update
        item2.update
        expect(item1.quality).to eq 0
        expect(item2.quality).to eq 0
      end

      it "does not decrement quality value if quality == 0" do
        item1 = NormalItem.new("foo", 8, 0)
        item2 = NormalItem.new("foo", 3, 0)
        item3 = NormalItem.new("foo", -1, 0)
        item1.update
        item2.update
        item3.update
        expect(item1.quality).to eq 0
        expect(item2.quality).to eq 0
        expect(item3.quality).to eq 0
      end

      it "subtracts 2 from quality when sell_in passed" do
        item = NormalItem.new("foo", -1, 2)
        item.update
        expect(item.quality).to eq 0
      end

      it "subtracts just 1, not 2, (when sell_in value is <= 0) from quality if quality == 1" do
        item = NormalItem.new("foo", -1, 1)
        item.update
        expect(item.quality).to eq 0
      end

      it "subtracts 1 from sell_in" do
        item1 = NormalItem.new("foo", 10, 0)
        item2 = NormalItem.new("foo", 0, 0)
        item3 = NormalItem.new("foo", -10, 0)
        item1.update
        item2.update
        item3.update
        expect(item1.sell_in).to eq 9
        expect(item2.sell_in).to eq -1
        expect(item3.sell_in).to eq -11
      end
  end
end
