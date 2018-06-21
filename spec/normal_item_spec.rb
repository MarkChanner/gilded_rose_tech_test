require 'item'
require 'normal_item'

describe NormalItem do
  let(:normal_item) { NormalItem.new("foo", 0, 0) }

  describe "#update" do
      it "does not change the name" do
        items = [NormalItem.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end

      it "subtracts 1 from quality" do
        item0 = NormalItem.new("foo", 8, 1)
        item1 = NormalItem.new("foo", 3, 1)
        item2 = NormalItem.new("foo", 0, 1)
        items = [item0, item1, item2]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
      end

      it "does not decrement quality value if quality == 0" do
        item0 = NormalItem.new("foo", 8, 0)
        item1 = NormalItem.new("foo", 3, 0)
        item2 = NormalItem.new("foo", -1, 0)
        items = [item0, item1, item2]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
      end

      it "subtracts 2 from quality when sell_in passed" do
        items = [NormalItem.new("foo", -1, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "subtracts just 1, not 2, (when sell_in value is <= 0) from quality if quality == 1" do
        items = [NormalItem.new("foo", -1, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "subtracts 1 from sell_in" do
        item0 = NormalItem.new("foo", 20, 0)
        item1 = NormalItem.new("foo", 10, 0)
        item2 = NormalItem.new("foo", 0, 0)
        item3 = NormalItem.new("foo", -10, 0)
        items = [item0, item1, item2, item3]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 19
        expect(items[1].sell_in).to eq 9
        expect(items[2].sell_in).to eq -1
        expect(items[3].sell_in).to eq -11
      end
  end
end
