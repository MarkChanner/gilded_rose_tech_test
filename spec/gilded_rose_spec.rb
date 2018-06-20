require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "subtracts 1 from sell_in for items, except 'Sulfuras, Hand of Ragnaros'" do
      item0 = Item.new("foo", 0, 0)
      item1 = Item.new("Sulfuras, Hand of Ragnaros", 0, 0)
      item2 = Item.new("Aged Brie", 0, 0)
      item3 = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)
      items = [item0, item1, item2, item3]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
      expect(items[1].sell_in).to eq 0
      expect(items[2].sell_in).to eq -1
      expect(items[3].sell_in).to eq -1
    end

    it "does not change the quality of any item to below zero" do
      item0 = Item.new("foo", 0, 0)
      item1 = Item.new("Sulfuras, Hand of Ragnaros", 0, 0)
      item2 = Item.new("Aged Brie", 0, 0)
      item3 = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 0)
      items = [item0, item1, item2, item3]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 0
      expect(items[2].quality).to be >= 0
      expect(items[3].quality).to be >= 0
    end

    it "never changes the quality of 'Sulfuras, Hand of Ragnaros'" do
      item0 = Item.new("Sulfuras, Hand of Ragnaros", 11, 5)
      item1 = Item.new("Sulfuras, Hand of Ragnaros", 50, 5)
      item2 = Item.new("Sulfuras, Hand of Ragnaros", 0, 5)
      item3 = Item.new("Sulfuras, Hand of Ragnaros", -4, 5)
      items = [item0, item1, item2, item3]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 5
      expect(items[1].quality).to eq 5
      expect(items[2].quality).to eq 5
      expect(items[3].quality).to eq 5
    end

    it "subtracts 1 from quality for normal items (not Aged Brie, etc)" do
      item0 = Item.new("foo", 8, 1)
      item1 = Item.new("foo", 3, 1)
      item2 = Item.new("foo", 0, 1)
      items = [item0, item1, item2]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[0].quality).to eq 0
      expect(items[0].quality).to eq 0
    end

    it "does not subtract from quality for normal items if quality == 0" do
      item0 = Item.new("foo", 8, 0)
      item1 = Item.new("foo", 3, 0)
      item2 = Item.new("foo", -1, 0)
      items = [item0, item1, item2]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[0].quality).to eq 0
      expect(items[0].quality).to eq 0
    end

    it "subtracts 2 from quality for normal items when sell_in passed" do
      items = [Item.new("foo", -1, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "only subtracts 1 from quality for normal items when sell_in passed if quality == 1" do
      items = [Item.new("foo", -1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "adds 1 to quality if name is 'Aged Brie' with sell_in value of > 0" do
      items = [Item.new("Aged Brie", 1, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    it "does not increment quality of 'Aged Brie' if quality == 50" do
      items = [Item.new("Aged Brie", 1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "adds 2 to quality if is 'Aged Brie' with sell_in value of zero or less" do
      items = [Item.new("Aged Brie", 0, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 4
    end

    it "only adds 1 to quality of 'Aged Brie' with sell_in value of zero or less if quality == 49" do
      items = [Item.new("Aged Brie", 0, 49)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "adds 2 to quality if is 'Backstage passes..' with > 5 and <= 10 sell_in" do
      item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 2)
      item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)
      items = [item0, item1]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 4
      expect(items[1].quality).to eq 4
    end

    it "adds 3 to quality if is 'Backstage passes..' with > 0 and < 5 sell_in" do
      item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 2)
      item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 2)
      items = [item0, item1]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 5
      expect(items[1].quality).to eq 5
    end

    it "sets quality to 0 if is 'Backstage passes..' with <= 0 sell_in" do
      item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)
      item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 2)
      items = [item0, item1]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 0
    end

  end

end
