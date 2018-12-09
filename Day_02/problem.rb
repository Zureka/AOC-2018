require_relative 'box_ids'

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

  def self.difference_count_of_ids(id1, id2)
    id1_letters = id1.chars
    id2_letters = id2.chars
    count = 0

    id1_letters.each_with_index do |letter, index|
      count += 1 if letter != id2_letters[index]
    end

    count
  end

  def self.find_nearly_identical_ids_for_collection(collection)
    result = {}

    catch(:found_match) do
      collection.each do |id1|
        collection.each do |id2|
          difference_count = difference_count_of_ids(id1, id2)
          if difference_count == 1
            result = { id1: id1, id2: id2 }
            throw :found_match
          end
        end
      end
    end

    result
  end

  def self.find_letters_with_count(str, count)
    letters = ('a'..'z').to_a

    letters.each do |letter|
      return true if str.count(letter) == count
    end

    false
  end

  private_class_method :find_letters_with_count
end
