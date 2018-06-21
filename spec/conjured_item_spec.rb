require 'item'
require 'conjured_item'

describe ConjuredItem do

  describe "#update" do
    it "degrades in Quality twice as fast as normal items" do
      item1 = ConjuredItem.new("Conjured", 5, 4)
      item2 = ConjuredItem.new("Conjured", 0, 4)
      item1.update
      item2.update
      expect(item1.quality).to eq 2
      expect(item2.quality).to eq 0
    end

    it "does not change the qualty to below zero" do
      item1 = ConjuredItem.new("Conjured", 5, 0)
      item2 = ConjuredItem.new("Conjured", 5, 1)
      item3 = ConjuredItem.new("Conjured", -1, 3)
      item4 = ConjuredItem.new("Conjured", -1, 2)
      item1.update
      item2.update
      item3.update
      item4.update
      expect(item1.quality).to eq 0
      expect(item2.quality).to eq 0
      expect(item3.quality).to eq 0
      expect(item4.quality).to eq 0
    end
  end
end
