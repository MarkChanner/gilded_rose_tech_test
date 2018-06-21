require 'item'
require 'backstage_pass_item'

describe BackstagePassItem do

  describe "#update" do
    it "adds 1 to quality if sell_in value is > 10" do
      item = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 11, 2)
      item.update
      expect(item.quality).to eq 3
    end

    it "does not add 1 to quality if quality == 50 (when sell_in value is > 10)" do
      item = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)
      item.update
      expect(item.quality).to eq 50
    end

    it "adds 2 to quality if sell_in value is > 5 and <= 10" do
      item1 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 6, 2)
      item2 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)
      item1.update
      item2.update
      expect(item1.quality).to eq 4
      expect(item2.quality).to eq 4
    end

    it "adds just 1 to quality if quality == 49 (when sell_in value is > 5 and <= 10)" do
      item1 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 6, 49)
      item2 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)
      item1.update
      item2.update
      expect(item1.quality).to eq 50
      expect(item2.quality).to eq 50
    end

    it "adds 3 to quality if is 'Backstage passes..' with > 0 and < 5 sell_in" do
      item1 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 1, 2)
      item2 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 4, 2)
      item1.update
      item2.update
      expect(item1.quality).to eq 5
      expect(item2.quality).to eq 5
    end

    it "adds 2, not 3, to quality if quality == 48 (when sell_in value is > 0 and < 5)" do
      item1 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 1, 48)
      item2 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 4, 48)
      item1.update
      item2.update
      expect(item1.quality).to eq 50
      expect(item2.quality).to eq 50
    end

    it "sets quality to 0 if is 'Backstage passes..' with <= 0 sell_in" do
      item1 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)
      item2 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", -1, 50)
      item1.update
      item2.update
      expect(item1.quality).to eq 0
      expect(item2.quality).to eq 0
    end

    it "subtracts 1 from sell_in" do
      item1 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)
      item2 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)
      item3 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", -10, 0)
      item1.update
      item2.update
      item3.update
      expect(item1.sell_in).to eq 9
      expect(item2.sell_in).to eq -1
      expect(item3.sell_in).to eq -11
    end

  end
end
