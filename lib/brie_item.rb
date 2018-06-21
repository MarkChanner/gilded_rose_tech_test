class BrieItem < Item

  def update
    increment_quality
    @sell_in -= 1
    increment_quality if @sell_in < 0
  end

  def decrement_quality
    @quality -= 1 if @quality > 0
  end

  def increment_quality
    @quality += 1 if @quality < 50
  end
end
