require_relative 'box_ids'
require 'pry'

class BoxIDChecksum
  def self.two_of_any_letter_count(str)
    find_letters_with_count(str, 2)
  end

  def self.three_of_any_letter_count(str)
    find_letters_with_count(str, 3)
  end

  def self.count_occurrences_for_collection(collection, count)
    if count == 2
      collection.select { |str| two_of_any_letter_count(str) }.count
    elsif count == 3
      collection.select { |str| three_of_any_letter_count(str) }.count
    end
  end

  def self.get_checksum_for_collection(collection)
    two_letter_count = count_occurrences_for_collection(collection, 2)
    three_letter_count = count_occurrences_for_collection(collection, 3)

    two_letter_count * three_letter_count
  end

  def self.find_letters_with_count(str, count)
    letters = ('a'..'z').to_a

    letters.each do |letter|
      if (str.count(letter) == count)
        return true
      end
    end

    false
  end

  private_class_method :find_letters_with_count
end
