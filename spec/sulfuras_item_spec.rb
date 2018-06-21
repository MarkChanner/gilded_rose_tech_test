require 'item'
require 'sulfuras_item'

describe SulfurasItem do

  describe "#update" do
    it "never changes the quality value" do
      item0 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 11, 0)
      item1 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 50, 5)
      item2 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 15)
      item3 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", -4, 50)
      items = [item0, item1, item2, item3]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 5
      expect(items[2].quality).to eq 15
      expect(items[3].quality).to eq 50
    end

    it "never changes the sell_in value" do
      item0 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 11, 5)
      item1 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 50, 5)
      item2 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 5)
      item3 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", -4, 5)
      items = [item0, item1, item2, item3]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 11
      expect(items[1].sell_in).to eq 50
      expect(items[2].sell_in).to eq 0
      expect(items[3].sell_in).to eq -4
    end

  end
end
