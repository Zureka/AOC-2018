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
      collection = %w[aa bb]
      assert_equal 2, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
    end

    it "finds none with count of two and collection of threes" do
      collection = %w[aaa bbb]
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
    end

    it "finds two with count of three" do
      collection = %w[aaa bbb]
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
      collection = %w[aa bb cc]
      assert_equal 3, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 0, BoxIDChecksum.get_checksum_for_collection(collection)
    end

    it "returns a 0 checksum with only three-letter occurrences" do
      collection = %w[aaa bbb ccc]
      assert_equal 0, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 3, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 0, BoxIDChecksum.get_checksum_for_collection(collection)
    end

    it "returns 1 with one of each type of occurrence" do
      collection = %w[aa bbb]
      assert_equal 1, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 1, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 1, BoxIDChecksum.get_checksum_for_collection(collection)
    end

    it "works for the example case from the problem spec" do
      collection = %w[abcdef bababc abbcde abcccd aabcdd abcdee ababab]
      assert_equal 4, BoxIDChecksum.count_occurrences_for_collection(collection, 2)
      assert_equal 3, BoxIDChecksum.count_occurrences_for_collection(collection, 3)
      assert_equal 12, BoxIDChecksum.get_checksum_for_collection(collection)
    end
  end

  describe "difference count of IDs" do
    it "returns 0 for identical strings" do
      a = 'abc'
      b = 'abc'
      assert_equal 0, BoxIDChecksum.difference_count_of_ids(a, b)
    end

    it "returns 1 if words differ by 1 letter each" do
      a = 'abce'
      b = 'abcd'
      assert_equal 1, BoxIDChecksum.difference_count_of_ids(a, b)
    end
  end

  describe "find nearly identical IDs for collection" do
    it "returns two IDs that only differ by 1 letter" do
      collection = %w[aaab aaac bbbb]
      expected = { id1: 'aaab', id2: 'aaac' }
      assert_equal expected, BoxIDChecksum.find_nearly_identical_ids_for_collection(collection)
    end

    it "returns an empty hash if no IDs are identical" do
      collection = %w[aaaa bbbb cccc]
      expected = {}
      assert_equal expected, BoxIDChecksum.find_nearly_identical_ids_for_collection(collection)
    end

    it "returns an empty hash if IDs aren't close enough to being identical" do
      collection = %w[aaaa aabb]
      expected = {}
      assert_equal expected, BoxIDChecksum.find_nearly_identical_ids_for_collection(collection)
    end

    it "returns the two matching box IDs for the answer" do
      collection = BOX_IDS # from box_ids.rb
      expected = { id1: "aixwcbzrmdvpsjfgllthdyeoqe", id2: "aixwcbzrmdvpsjfgllthdyioqe" }
      assert_equal expected, BoxIDChecksum.find_nearly_identical_ids_for_collection(collection)
    end
  end
end
