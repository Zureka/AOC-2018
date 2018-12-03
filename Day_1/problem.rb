require_relative 'frequency_list'

def get_answer_one
  puts "Result of frequency changes is #{FREQUENCY_CHANGES.inject(&:+)}"
end

def get_answer_two
  sum = 0
  observed_frequencies = []
  first_duplicate = 0

  catch(:done) do
    loop do
      FREQUENCY_CHANGES.each do |change|
        sum += change
        if observed_frequencies.include? sum
          first_duplicate = sum
          throw :done
        end
        observed_frequencies << sum
      end
    end
  end

  puts "First duplicate frequency observed: #{first_duplicate}"
end

puts "Which part would you like the answer for? (1 or 2)"
input = gets.chomp

if input.eql? '1'
  get_answer_one
elsif input.eql? '2'
  get_answer_two
else
  puts 'You need to figure out what you want before asking me again...'
  puts 'Goodbye!'
end
