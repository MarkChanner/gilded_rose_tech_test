require 'gilded_rose'

describe GildedRose do
  let(:normal_item) { spy :normal_item, update: nil }
  let(:backstage_pass_item) { spy :backstage_pass_item, update: nil }
  let(:conjured_item) { spy :conjured_item, update: nil }
  let(:sulfuras_item) { spy :sulfuras_item, update: nil }

  describe "#update_quality" do
    it "calls the update method once on each item in the passed-in array" do
      items = [normal_item, backstage_pass_item, conjured_item, sulfuras_item]
      GildedRose.new(items).update_quality()
      expect(normal_item).to have_received(:update).once
      expect(backstage_pass_item).to have_received(:update).once
      expect(conjured_item).to have_received(:update).once
      expect(sulfuras_item).to have_received(:update).once
    end
  end
end
