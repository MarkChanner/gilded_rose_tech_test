require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "changes the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "subtracts 1 from sell_in for items, except 'Sulfuras, Hand of Ragnaros'" do
      item1 = Item.new("foo", 0, 0)
      item2 = Item.new("Sulfuras, Hand of Ragnaros", 0, 0)
      item3 = Item.new("Aged Brie", 0, 0)
      item4 = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)
      items = [item1, item2, item3, item4]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
      expect(items[1].sell_in).to eq 0
      expect(items[2].sell_in).to eq -1
      expect(items[3].sell_in).to eq -1
    end

    it "does not change the quality of an item to below zero" do
      item1 = Item.new("foo", 0, 0)
      item2 = Item.new("Sulfuras, Hand of Ragnaros", 0, 0)
      item3 = Item.new("Aged Brie", 0, 0)
      item4 = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 0)
      items = [item1, item2, item3, item4]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 0
      expect(items[2].quality).to be >= 0
      expect(items[3].quality).to be >= 0
    end

    it "subtracts 1 from quality for normal items (not Aged Brie, etc)" do
      items = [Item.new("foo", 0, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "subtracts 2 from quality for normal items when sell by date passed" do
      items = [Item.new("foo", -1, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "adds 1 to quality if name is 'Aged Brie'" do
      items = [Item.new("Aged Brie", 4, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    it "adds 2 to quality if is 'Aged Brie' with sell_in value of zero or less" do
      items = [Item.new("Aged Brie", 0, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 4
    end

    it "adds 2 to quality if is 'Backstage passes..' with > 5 and <= 10 sell_in" do
      item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 2)
      item2 = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)
      items = [item1, item2]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 4
      expect(items[1].quality).to eq 4
    end

    it "adds 3 to quality if is 'Backstage passes..' with > 0 and < 5 sell_in" do
      item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 2)
      item2 = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 2)
      items = [item1, item2]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 5
      expect(items[1].quality).to eq 5
    end

    it "sets quality to 0 if is 'Backstage passes..' with <= 0 sell_in" do
      item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)
      item2 = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 2)
      items = [item1, item2]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 0
    end
  end

end
