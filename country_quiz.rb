# frozen_string_literal: true

require_relative 'utils/terminal_logger'

# countries = ["Japan", "France", "Brazil", "Canada", "Germany", "Egypt", "Australia", "India", "Italy", "Mexico", "Spain", "Argentina", "Thailand"]
# capitals  = ["Tokyo", "Paris", "Brasilia", "Ottawa", "Berlin", "Cairo", "Canberra", "New Delhi", "Rome", "Mexico City", "Madrid", "Buenos Aires", "Bangkok"]

# cc_hash = Hash[countries.zip(capitals)]
# cc_hash = countries.zip(capitals).to_h

cc_hash = {
  Japan: 'Tokyo',
  France: 'Paris',
  Brazil: 'Brasilia',
  Canada: 'Ottawa',
  Germany: 'Berlin',
  Egypt: 'Cairo',
  Australia: 'Canberra',
  India: 'New Delhi',
  Italy: 'Rome',
  Mexico: 'Mexico City',
  Spain: 'Madrid',
  Argentina: 'Buenos Aires',
  Thailand: 'Bangkok'
}

correct_answers_count = 0

cc_hash.each do |country, capital|
  # country = cc_hash_member[0]
  # capital = cc_hash_member[1]

  puts "The capital of #{country} is ...?}"

  user_input = gets.strip.downcase
  answer_correct = user_input == capital.downcase

  if answer_correct
    correct_answers_count += 1
    puts TerminalLogger.render_success("Yes!!! The capital of #{country} is #{capital}")
  else
    puts TerminalLogger.render_error("NOOOO!!! The capital of #{country} is #{capital}")
  end
end

puts "\n\n"

user_won = correct_answers_count >= 7

if user_won
  puts TerminalLogger.render_success('           ')
  puts TerminalLogger.render_success('＼(★^∀^★)／')
  puts TerminalLogger.render_success('           ')
  puts "\n"
  puts TerminalLogger.render_success('Yay! You won!')
else
  puts TerminalLogger.render_error('              ')
  puts TerminalLogger.render_error('(╯°□°)╯︵ ┻━┻ ')
  puts TerminalLogger.render_error('              ')
  puts "\n"
  puts TerminalLogger.render_error('You lost!!! Cry about it!!!')
end
