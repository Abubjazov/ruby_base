require_relative 'utils/terminal_logger'

RIGHT_GUESS = TerminalLogger.render_success("Ты угадал!!! ＼(★^∀^★)／")
WRONG_GUESS = TerminalLogger.render_error("Попытки кончились, ты проиграл!  (╯°□°)╯︵ ┻━┻")

random_guess = (rand * 10).to_i + 1
has_won = false

puts "Я загОдал число от 1 до 10! ОтгОдай!!! )"
puts random_guess

3.times do |i|
  puts "Попытка #{i + 1}/3. Введи число: "
  guess = gets.to_i

  if random_guess == guess 
    puts RIGHT_GUESS
    has_won = true

    break 
  elsif guess < random_guess 
    puts "Моё число бОООльше... (‾◡◝)"
  else
    puts "Моё число мЕЕЕньше... ┐(‘～;)┌"
  end
end

unless has_won
  puts "Правильное число было: #{random_guess}"
  puts WRONG_GUESS
end