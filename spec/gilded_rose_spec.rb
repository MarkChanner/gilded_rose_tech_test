require 'gilded_rose'

describe GildedRose do

  it "does not change the quality of any item to below zero" do
    item0 = NormalItem.new("foo", 0, 0)
    item1 = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 0)
    item2 = BrieItem.new("Aged Brie", 0, 0)
    item3 = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 1, 0)
    items = [item0, item1, item2, item3]
    GildedRose.new(items).update_quality()
    expect(items[0].quality).to eq 0
    expect(items[1].quality).to eq 0
    expect(items[2].quality).to be >= 0
    expect(items[3].quality).to be >= 0
  end
end
