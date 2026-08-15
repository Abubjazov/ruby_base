require_relative 'terminal_logger'

RIGHT_GUESS = TerminalLogger.render_success("УГАДАЛ!!! ＼(★^∀^★)／")
WRONG_GUESS = TerminalLogger.render_error("НЕ УГАДАЛ!!! (╯°□°)╯︵ ┻━┻")

random_guess = (rand * 10).to_i + 1

puts "Я загОдал число от 1 до 10! ОтгОдай!!! )"
puts random_guess

guess = gets.to_i

puts random_guess == guess ? RIGHT_GUESS : WRONG_GUESS