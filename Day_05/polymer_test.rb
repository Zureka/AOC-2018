require 'minitest/autorun'
require_relative 'polymer'

describe "Polymers" do
  describe "initialize" do
    it "builds a list of units that react due to opposite polarities" do
      subject = Polymers.new
      assert_equal 52, subject.polarity_matches.count
      assert_equal "aA", subject.polarity_matches.to_a[0]
      assert_equal "Aa", subject.polarity_matches.to_a[1]
      assert_equal "bB", subject.polarity_matches.to_a[2]
      assert_equal "Bb", subject.polarity_matches.to_a[3]
      assert_equal "Zz", subject.polarity_matches.to_a.last
    end
  end

  describe "cancel units of opposite polarity" do
    before do
      @subject = Polymers.new
    end

    it "returns empty string if given an empty string" do
      polymer = ""
      expected = ""
      assert_equal expected, @subject.cancel_units_of_opposite_polarity(polymer)
    end

    it "returns empty string if it cancels all units of opposite polarity with one pair" do
      polymer = "aA"
      expected = ""
      assert_equal expected, @subject.cancel_units_of_opposite_polarity(polymer)
    end

    it "returns empty string if it cancels all units of opposite polarity with two pairs" do
      polymer = "aAbB"
      expected = ""
      assert_equal expected, @subject.cancel_units_of_opposite_polarity(polymer)
    end

    it "returns the remaining units joined as a polymer if no more units can be canceled" do
      polymer = "dabAcCaCBAcCcaDA"
      expected = "dabCBAcaDA"
      assert_equal expected, @subject.cancel_units_of_opposite_polarity(polymer)
    end
  end
end
