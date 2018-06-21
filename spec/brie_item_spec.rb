require 'item'
require 'brie_item'

describe BrieItem do

  describe "#update" do
    it "adds just 1 to quality if sell_in value is > 0" do
      item = BrieItem.new("Aged Brie", 1, 2)
      item.update
      expect(item.quality).to eq 3
    end

    it "does not increment quality if quality >= 50" do
      item = BrieItem.new("Aged Brie", 1, 50)
      item.update
      expect(item.quality).to eq 50
    end

    it "adds 2 to quality if sell_in value is <= 0" do
      item = BrieItem.new("Aged Brie", 0, 2)
      item.update
      expect(item.quality).to eq 4
    end

    it "only adds 1 to quality if quality == 49 (when sell_in value is <= 0)" do
      item = BrieItem.new("Aged Brie", 0, 49)
      item.update
      expect(item.quality).to eq 50
    end

    it "subtracts 1 from sell_in" do
      item1 = BrieItem.new("Aged Brie", 10, 0)
      item2 = BrieItem.new("Aged Brie", 0, 0)
      item3 = BrieItem.new("Aged Brie", -10, 0)
      item1.update
      item2.update
      item3.update
      expect(item1.sell_in).to eq 9
      expect(item2.sell_in).to eq -1
      expect(item3.sell_in).to eq -11
    end

    it "does not change the quality to below zero" do
      item = BrieItem.new("Aged Brie", 1, 0)
      expect(item.quality).to eq 0
    end
  end
end
