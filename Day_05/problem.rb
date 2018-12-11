require 'set'

lowercase = ('a'..'z').to_a
uppercase = ('A'..'Z').to_a
list = Set.new

lowercase.each_with_index do |letter, index|
  list << letter + uppercase[index]
  list << uppercase[index] + letter
end

