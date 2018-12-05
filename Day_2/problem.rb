require_relative 'box_ids'
require 'pry'

class BoxIDChecksum
  attr_reader :two_letter_count
  attr_reader :three_letter_count
  
  def initialize
    @letters = ('a'..'z').to_a
  end

  def two_of_any_letter_count(str)
    result = 0
    @letters.each do |letter|
      if (str.count(letter) == 2)
        result += 1
      end
    end
    result
  end

  def three_of_any_letter_count(str)
    result = 0
    @letters.each do |letter|
      if (str.count(letter) == 3)
        result += 1
      end
    end
    result
  end
end
