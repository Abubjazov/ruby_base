require_relative 'terminal_logger'

countries = ["Japan", "France", "Brazil", "Canada", "Germany", "Egypt", "Australia", "India", "Italy", "Mexico", "Spain", "Argentina", "Thailand"]
capitals  = ["Tokyo", "Paris", "Brasilia", "Ottawa", "Berlin", "Cairo", "Canberra", "New Delhi", "Rome", "Mexico City", "Madrid", "Buenos Aires", "Bangkok"]

correct_answers_count = 0

countries.each.with_index do |country, index|
    puts "The capital of #{country} is ...?}"

    user_input = gets.strip.downcase
    answer_correct = user_input == capitals[index].downcase

    if answer_correct
        correct_answers_count = correct_answers_count + 1
        puts TerminalLogger.render_success("Yes!!! The capital of #{country} is #{capitals[index]}") 
    else
        puts TerminalLogger.render_error("NOOOO!!! The capital of #{country} is #{capitals[index]}")
    end
end

user_won = correct_answers_count >= 7

puts "\n\n"

if user_won 
    puts TerminalLogger.render_success("           ")
    puts TerminalLogger.render_success("＼(★^∀^★)／")
    puts TerminalLogger.render_success("           ")
    puts "\n"
    puts TerminalLogger.render_success("Yay! You won!")
else
    puts TerminalLogger.render_error("              ")
    puts TerminalLogger.render_error("(╯°□°)╯︵ ┻━┻ ")
    puts TerminalLogger.render_error("              ")
    puts "\n"
    puts TerminalLogger.render_error("You lost!!! Cry about it!!!")
end