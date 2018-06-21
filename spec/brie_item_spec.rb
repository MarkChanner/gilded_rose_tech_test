require 'item'
require 'brie_item'

describe BrieItem do
  let(:brie_item) { BrieItem.new("Aged Brie", 0, 0) }

  describe "#update" do
    it "adds just 1 to quality if sell_in value is > 0" do
      items = [BrieItem.new("Aged Brie", 1, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    it "does not increment quality if quality >= 50" do
      items = [BrieItem.new("Aged Brie", 1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "adds 2 to quality if sell_in value is <= 0" do
      items = [BrieItem.new("Aged Brie", 0, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 4
    end

    it "only adds 1 to quality if quality == 49 (when sell_in value is <= 0)" do
      items = [BrieItem.new("Aged Brie", 0, 49)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "subtracts 1 from sell_in" do
      item0 = BrieItem.new("Aged Brie", 20, 0)
      item1 = BrieItem.new("Aged Brie", 10, 0)
      item2 = BrieItem.new("Aged Brie", 0, 0)
      item3 = BrieItem.new("Aged Brie", -10, 0)
      items = [item0, item1, item2, item3]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 19
      expect(items[1].sell_in).to eq 9
      expect(items[2].sell_in).to eq -1
      expect(items[3].sell_in).to eq -11
    end
  end
end
