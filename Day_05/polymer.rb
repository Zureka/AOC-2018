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

    polymer.chars.count
  end

  def polymer_contains_opposing_units(polymer)
    @polarity_matches.any? { |pm| polymer.include? pm }
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
subject.cancel_units_of_opposite_polarity("asdfqwer")

File.open('data.txt').each do |line|
  puts subject.cancel_units_of_opposite_polarity(line)
end
