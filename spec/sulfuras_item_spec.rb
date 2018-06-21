require 'item'
require 'sulfuras_item'

describe SulfurasItem do

  describe "#update" do
    it "never changes the quality value" do
      item1 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 50, 5)
      item2 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 15)
      item3 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", -4, 50)
      item1.update
      item2.update
      item3.update
      expect(item1.quality).to eq 5
      expect(item2.quality).to eq 15
      expect(item3.quality).to eq 50
    end

    it "never changes the sell_in value" do
      item1 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 50, 5)
      item2 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 5)
      item3 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", -4, 5)
      item1.update
      item2.update
      item3.update
      expect(item1.sell_in).to eq 50
      expect(item2.sell_in).to eq 0
      expect(item3.sell_in).to eq -4
    end

  end
end
