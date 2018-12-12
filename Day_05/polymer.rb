class Polymers
  attr_reader :polarity_matches

  def initialize
    @polarity_matches = build_polarity_matches
  end

  def cancel_units_of_opposite_polarity(polymer)
    while polymer_contains_opposing_units(polymer)
      @polarity_matches.each do |pm|
        polymer.slice! pm if polymer.include? pm
      end
    end

    polymer
  end

  def polymer_contains_opposing_units(polymer)
    @polarity_matches.any? { |pm| polymer.include? pm }
  end

  def determine_hindering_unit(polymer)
    results = []
    ('a'..'z').to_a.each do |letter|
      shortened_polymer = remove_units_for_letter(polymer, letter)
      results << { letter: letter, count: cancel_units_of_opposite_polarity(shortened_polymer).size }
    end

    results.sort_by { |v| v[:count] }
  end

  def remove_units_for_letter(polymer, letter)
    (polymer.chars - [letter] - [letter.upcase]).join
  end

  def build_polarity_matches
    lowercase = ('a'..'z').to_a
    uppercase = ('A'..'Z').to_a
    list = []

    lowercase.each_with_index do |letter, index|
      list << letter + uppercase[index]
      list << uppercase[index] + letter
    end

    # The list should only contain pairs of uppercase/lowercase letters
    # (i.e. aA, Aa, bB, etc.) aF is not a valid pair for this list
    raise "Failed to build the list of contrasting polymers" if list.include? "aF"

    list
  end

  private_methods :build_polarity_matches
end

subject = Polymers.new

part1_answer = 0
part2_answer = []

File.open('data.txt').each do |line|
  remaining_polymer = subject.cancel_units_of_opposite_polarity(line)
  part1_answer = remaining_polymer.size
  part2_answer = subject.determine_hindering_unit(remaining_polymer).first[:count]
end

puts """--- Part 1 ---
Answer: #{part1_answer}

"""
puts """--- Part 2 ---
Answer: #{part2_answer}

"""
