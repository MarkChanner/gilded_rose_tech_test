class NormalItem < Item

  def update
    decrement_quality
    @sell_in -= 1
    decrement_quality if @sell_in < 0
  end

  private
  def decrement_quality
    @quality -= 1 if @quality > 0
  end

end
