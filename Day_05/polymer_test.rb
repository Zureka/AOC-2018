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

  # describe "cancel units of opposite polarity" do
  #   before do
  #     @subject = Polymers.new
  #   end
  #
  #   it "returns empty string if given an empty string" do
  #     polymer = ""
  #     expected = ""
  #     assert_equal expected, @subject.cancel_units_of_opposite_polarity(polymer)
  #   end
  #
  #   it "returns empty string if it cancels all units of opposite polarity with one pair" do
  #     polymer = "aA"
  #     expected = ""
  #     assert_equal expected, @subject.cancel_units_of_opposite_polarity(polymer)
  #   end
  #
  #   it "returns empty string if it cancels all units of opposite polarity with two pairs" do
  #     polymer = "aAbB"
  #     expected = ""
  #     assert_equal expected, @subject.cancel_units_of_opposite_polarity(polymer)
  #   end
  # end

  describe "current unit pairs" do
    before do
      @subject = Polymers.new
    end

    it "returns nil for an empty string" do
      polymer = ""
      expected = []
      assert_equal expected, @subject.current_unit_pairs(polymer)
    end

    it "returns a list with 1 element for a string with 1 character" do
      polymer = "a"
      expected = ["a"]
      assert_equal expected, @subject.current_unit_pairs(polymer)
    end

    it "returns a list with 1 element for a string with 2 characters" do
      polymer = "aA"
      expected = ["aA"]
      assert_equal expected, @subject.current_unit_pairs(polymer)
    end

    it "returns a list with 3 elements for a string with 6 characters" do
      polymer = "aAbBcC"
      expected = ["aA", "bB", "cC"]
      assert_equal expected, @subject.current_unit_pairs(polymer)
    end
  end
end
