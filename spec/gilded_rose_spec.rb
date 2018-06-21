require 'gilded_rose'

describe GildedRose do
  describe "#update_quality" do

    describe "on normal items (not Aged Brie, Backstage passes, or Sulfuras.., etc)" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end

      it "subtracts 1 from quality" do
        item0 = Item.new("foo", 8, 1)
        item1 = Item.new("foo", 3, 1)
        item2 = Item.new("foo", 0, 1)
        items = [item0, item1, item2]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
      end

      it "does not decrement quality value if quality == 0" do
        item0 = Item.new("foo", 8, 0)
        item1 = Item.new("foo", 3, 0)
        item2 = Item.new("foo", -1, 0)
        items = [item0, item1, item2]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
        expect(items[0].quality).to eq 0
      end

      it "subtracts 2 from quality when sell_in passed" do
        items = [Item.new("foo", -1, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "subtracts just 1, not 2, (when sell_in value is <= 0) from quality if quality == 1" do
        items = [Item.new("foo", -1, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "subtracts 1 from sell_in" do
        item0 = Item.new("foo", 20, 0)
        item1 = Item.new("foo", 10, 0)
        item2 = Item.new("foo", 0, 0)
        item3 = Item.new("foo", -10, 0)
        items = [item0, item1, item2, item3]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 19
        expect(items[1].sell_in).to eq 9
        expect(items[2].sell_in).to eq -1
        expect(items[3].sell_in).to eq -11
      end
    end

    describe "on Aged Brie items" do
      it "adds just 1 to quality if sell_in value is > 0" do
        items = [Item.new("Aged Brie", 1, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "does not increment quality if quality >= 50" do
        items = [Item.new("Aged Brie", 1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "adds 2 to quality if sell_in value is <= 0" do
        items = [Item.new("Aged Brie", 0, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
      end

      it "only adds 1 to quality if quality == 49 (when sell_in value is <= 0)" do
        items = [Item.new("Aged Brie", 0, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "subtracts 1 from sell_in" do
        item0 = Item.new("Aged Brie", 20, 0)
        item1 = Item.new("Aged Brie", 10, 0)
        item2 = Item.new("Aged Brie", 0, 0)
        item3 = Item.new("Aged Brie", -10, 0)
        items = [item0, item1, item2, item3]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 19
        expect(items[1].sell_in).to eq 9
        expect(items[2].sell_in).to eq -1
        expect(items[3].sell_in).to eq -11
      end
    end

    describe "on Backstage passes to a TAFKAL80ETC concert items" do
      it "adds just 1 to quality if sell_in value is > 10" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "does not add 1 to quality if quality == 50 (when sell_in value is > 10)" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "adds 2 to quality if sell_in value is > 5 and <= 10" do
        item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 2)
        item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)
        items = [item0, item1]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
        expect(items[1].quality).to eq 4
      end

      it "adds just 1 to quality if quality == 49 (when sell_in value is > 5 and <= 10)" do
        item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 49)
        item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)
        items = [item0, item1]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
        expect(items[1].quality).to eq 50
      end

      it "adds 3 to quality if is 'Backstage passes..' with > 0 and < 5 sell_in" do
        item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 2)
        item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 2)
        items = [item0, item1]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 5
        expect(items[1].quality).to eq 5
      end

      it "adds 2, not 3, to quality if quality == 48 (when sell_in value is > 0 and < 5)" do
        item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 48)
        item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 48)
        items = [item0, item1]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
        expect(items[1].quality).to eq 50
      end

      it "sets quality to 0 if is 'Backstage passes..' with <= 0 sell_in" do
        item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)
        item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 50)
        items = [item0, item1]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        expect(items[1].quality).to eq 0
      end

      it "subtracts 1 from sell_in" do
        item0 = Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 0)
        item1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)
        item2 = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)
        item3 = Item.new("Backstage passes to a TAFKAL80ETC concert", -10, 0)
        items = [item0, item1, item2, item3]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 19
        expect(items[1].sell_in).to eq 9
        expect(items[2].sell_in).to eq -1
        expect(items[3].sell_in).to eq -11
      end
    end

    describe "on Sulfuras, Hand of Ragnaros items" do
      it "never changes the quality value" do
        item0 = Item.new("Sulfuras, Hand of Ragnaros", 11, 0)
        item1 = Item.new("Sulfuras, Hand of Ragnaros", 50, 5)
        item2 = Item.new("Sulfuras, Hand of Ragnaros", 0, 15)
        item3 = Item.new("Sulfuras, Hand of Ragnaros", -4, 50)
        items = [item0, item1, item2, item3]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        expect(items[1].quality).to eq 5
        expect(items[2].quality).to eq 15
        expect(items[3].quality).to eq 50
      end

      it "never changes the sell_in value" do
        item0 = Item.new("Sulfuras, Hand of Ragnaros", 11, 5)
        item1 = Item.new("Sulfuras, Hand of Ragnaros", 50, 5)
        item2 = Item.new("Sulfuras, Hand of Ragnaros", 0, 5)
        item3 = Item.new("Sulfuras, Hand of Ragnaros", -4, 5)
        items = [item0, item1, item2, item3]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 11
        expect(items[1].sell_in).to eq 50
        expect(items[2].sell_in).to eq 0
        expect(items[3].sell_in).to eq -4
      end
    end

    describe "on Conjured items" do
      it "degrades in Quality twice as fast as normal items" do
        item0 = Item.new("Conjured", 5, 4)
        item1 = Item.new("Conjured", 0, 4)
        items = [item0, item1]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
        expect(items[1].quality).to eq 0
      end

      it "does not change the qualty to below zero" do
        item0 = Item.new("Conjured", 5, 0)
        item1 = Item.new("Conjured", 5, 1)
        item2 = Item.new("Conjured", -1, 3)
        item3 = Item.new("Conjured", -1, 2)
        items = [item0, item1, item2, item3]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        expect(items[1].quality).to eq 0
        expect(items[2].quality).to eq 0
        expect(items[3].quality).to eq 0
      end
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
  end

end
