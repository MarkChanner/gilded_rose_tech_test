require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "changes the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "does not change the quality of an item to below zero" do
      item1 = Item.new("foo", 0, 0)
      item2 = Item.new("Sulfuras, Hand of Ragnaros", 0, 0)
      item3 = Item.new("Aged Brie", 0, 0)
      item4 = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)
      items = [item1, item2, item3, item4]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be >= 0
      expect(items[1].quality).to be >= 0
      expect(items[2].quality).to be >= 0
      expect(items[3].quality).to eq 0
    end
  end

end
