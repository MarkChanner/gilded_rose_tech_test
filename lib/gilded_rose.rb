class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update(item)
    end
  end

  private
  def update(item)
    return if item.name == "Sulfuras, Hand of Ragnaros"
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      update_normal(item)
    end
    if item.name == "Aged Brie"
      update_brie(item)
    end

    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      if item.quality < 50
        item.quality += 1
        if item.sell_in < 11
          if item.quality < 50
            item.quality += 1
          end
        end
        if item.sell_in < 6
          if item.quality < 50
            item.quality += 1
          end
        end
        item.sell_in -= 1
      end
      if item.sell_in < 0
        item.quality = 0
      end
    end
  end

  def update_normal(item)
    decrement_quality(item)
    item.sell_in -= 1
    decrement_quality(item) if item.sell_in < 0
  end

  def update_brie(item)
    item.quality += 1 if item.quality < 50
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality += 1 if item.quality < 50
    end
  end

  def decrement_quality(item)
    item.quality -= 1 if item.quality > 0
  end
end
