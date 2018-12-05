require_relative 'problem'
require 'minitest/autorun'

describe BoxIDChecksum do
  before do
    @subject = BoxIDChecksum.new
  end
  
  describe "two of any letter count" do
    it "finds one" do
      assert_equal 1, @subject.two_of_any_letter_count('aa')
    end

    it "finds none" do
      assert_equal 0, @subject.two_of_any_letter_count('')
    end

    it "finds none if three of a kind" do
      assert_equal 0, @subject.two_of_any_letter_count('aaa')
    end

    it "finds more than one" do
      assert_equal 3, @subject.two_of_any_letter_count('aabbcc')
    end
  end

  describe "three of any letter count" do
    it "finds one" do
      assert_equal 1, @subject.three_of_any_letter_count('aaa')
    end

    it "finds none" do
      assert_equal 0, @subject.three_of_any_letter_count('')
    end

    it "finds none if two of a kind" do
      assert_equal 0, @subject.three_of_any_letter_count('aa')
    end

    it "finds none if four of a kind" do
      assert_equal 0, @subject.three_of_any_letter_count('aaaa')
    end

    it "finds more than one" do
      assert_equal 3, @subject.three_of_any_letter_count('aaabbbccc')
    end
  end
end