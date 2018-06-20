require 'item'

describe Item do
  let(:item) { Item.new("foo", 0, 0) }

  describe "#to_s" do
    it "returns name, sell_in and quality as a string" do
      expect(item.to_s).to eq "foo, 0, 0"
    end
  end

end
