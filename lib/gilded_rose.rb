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
    if item.name == "Aged Brie"
      update_brie(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      update_backstage(item)
    else
      update_normal(item)
    end
  end

  def update_normal(item)
    decrement_quality(item)
    item.sell_in -= 1
    decrement_quality(item) if item.sell_in < 0
  end

  def update_brie(item)
    increment_quality(item)
    item.sell_in -= 1
    increment_quality(item) if item.sell_in < 0
  end

  def update_backstage(item)
    increment_quality(item)
    increment_quality(item) if item.sell_in < 11
    increment_quality(item) if item.sell_in < 6
    item.sell_in -= 1
    item.quality = 0 if item.sell_in < 0
  end

  def decrement_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def increment_quality(item)
    item.quality += 1 if item.quality < 50
  end

end
