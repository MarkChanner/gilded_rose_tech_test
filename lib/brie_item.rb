class BrieItem < Item

  def update
    increment_quality
    decrement_sell_in
    increment_quality if @sell_in < 0
  end

  private
  def increment_quality
    @quality += 1 if @quality < 50
  end

  def decrement_sell_in
    @sell_in -= 1
  end
end
