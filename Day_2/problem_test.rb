require_relative 'problem'
require 'minitest/autorun'

describe BoxIDChecksum do

  describe "two of any letter count" do
    it "returns true if letter appears exactly twice" do
      assert_equal true, BoxIDChecksum.two_of_any_letter_count('aa')
    end

    it "returns false if letter appears more than twice" do
      assert_equal false, BoxIDChecksum.two_of_any_letter_count('aaa')
    end

    it "returns false for empty string" do
      assert_equal false, BoxIDChecksum.two_of_any_letter_count('')
    end

    it "returns true if multiple letters appear exactly twice" do
      assert_equal true, BoxIDChecksum.two_of_any_letter_count('aabbcc')
    end
  end

  describe "three of any letter count" do
    it "returns true if letter appears exactly three times" do
      assert_equal true, BoxIDChecksum.three_of_any_letter_count('aaa')
    end

    it "returns false if letter appears more than three times" do
      assert_equal false, BoxIDChecksum.three_of_any_letter_count('aaaa')
    end

    it "returns false for empty string" do
      assert_equal false, BoxIDChecksum.three_of_any_letter_count('')
    end

    it "returns true if multiple letters appear exactly three times" do
      assert_equal true, BoxIDChecksum.three_of_any_letter_count('aaaccc')
    end
  end

  describe "count occurrences for collection" do
    it "finds one with count of two" do
      collection = ['aa']
      assert_equal 1, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
    end

    it "finds two with count of two" do
      collection = ['aa', 'bb']
      assert_equal 2, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
    end

    it "finds none with count of two and collection of threes" do
      collection = ['aaa', 'bbb']
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
    end

    it "finds two with count of three" do
      collection = ['aaa', 'bbb']
      assert_equal 2, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
    end

    it "finds none" do
      collection = []
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
    end
  end

  describe "get checksum for collection" do
    it "returns a 0 checksum with only two-letter occurrences" do
      collection = ['aa', 'bb', 'cc']
      assert_equal 3, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 0, BoxIDChecksum.get_checksum_for_collection(collection)
    end

    it "returns a 0 checksum with only three-letter occurrences" do
      collection = ['aaa', 'bbb', 'ccc']
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 3, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 0, BoxIDChecksum.get_checksum_for_collection(collection)
    end

    it "returns 1 with one of each type of occurrence" do
      collection = ['aa', 'bbb']
      assert_equal 1, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 1, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 1, BoxIDChecksum.get_checksum_for_collection(collection)
    end

    it "works for the example case from the problem spec" do
      collection = ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']
      assert_equal 4, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 3, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 12, BoxIDChecksum.get_checksum_for_collection(collection)
    end
  end
end