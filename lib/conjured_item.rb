class ConjuredItem < Item

  def update
    update_once
    update_once
  end

  private
  def update_once
    decrement_quality
    decrement_sell_in
    decrement_quality if @sell_in < 0
  end

  def decrement_quality
    @quality -= 1 if @quality > 0
  end

  def decrement_sell_in
    @sell_in -= 1
  end

end
