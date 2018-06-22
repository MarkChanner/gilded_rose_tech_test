class BackstagePassItem < Item

  def update
    increment_quality
    increment_quality if @sell_in < 11
    increment_quality if @sell_in < 6
    decrement_sell_in
    @quality = 0 if @sell_in < 0
  end

  private
  def increment_quality
    @quality += 1 if @quality < 50
  end

  def decrement_sell_in
    @sell_in -= 1
  end
end
