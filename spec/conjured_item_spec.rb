require 'item'
require 'conjured_item'

describe ConjuredItem do

  describe "#update" do
    it "degrades in Quality twice as fast as normal items" do
      item0 = ConjuredItem.new("Conjured", 5, 4)
      item1 = ConjuredItem.new("Conjured", 0, 4)
      items = [item0, item1]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
      expect(items[1].quality).to eq 0
    end

    it "does not change the qualty to below zero" do
      item0 = ConjuredItem.new("Conjured", 5, 0)
      item1 = ConjuredItem.new("Conjured", 5, 1)
      item2 = ConjuredItem.new("Conjured", -1, 3)
      item3 = ConjuredItem.new("Conjured", -1, 2)
      items = [item0, item1, item2, item3]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 0
      expect(items[2].quality).to eq 0
      expect(items[3].quality).to eq 0
    end

  end
end
