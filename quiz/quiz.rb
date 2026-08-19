require 'yaml'

require_relative '../utils/terminal_logger'

a_code = 'A'.ord

puts "Введите ваше имя:"
user_name = gets.strip
current_time = Time.now.strftime('%d-%m-%Y_%H-%M-%S')
file_name = "QUIZ_#{user_name}_#{current_time}.txt"

current_path = File.dirname(__FILE__)
all_questions = YAML.safe_load_file("#{current_path}/questions.yml", symbolize_names: true)

correct_answers_count = 0
incorrect_answers_count = 0

all_questions.shuffle.each do |item|

  puts "\n\n" 
  header_text = ">>>>>>>  #{item[:question]}  <<<<<<<"
  puts TerminalLogger.render_success(" " * header_text.length)
  puts TerminalLogger.render_success(header_text)
  puts TerminalLogger.render_success(" " * header_text.length)
  puts "\n"

  answers = item[:answers].shuffle.each_with_index.inject({}) do |result, (answer, i)|
    answer_char = (a_code + i).chr
    
    result[answer_char] = answer

    puts "#{answer_char}. #{answer}"

    result
  end

  puts "\n"

  loop do
    puts "Введите ваш ответ:"
    user_answer = gets.strip[0].upcase

    if user_answer.between?('A', 'D')
      user_answer = answers[user_answer]

      answer_correct = user_answer == item[:correct_answer] 

      if answer_correct
        correct_answers_count += 1

        puts TerminalLogger.render_success("           ")
        puts TerminalLogger.render_success("＼(★^∀^★)／")
        puts TerminalLogger.render_success("           ")
        puts "\n"
        puts TerminalLogger.render_success("Да!!! Это правильный ответ!")
      else
        incorrect_answers_count += 1

        puts TerminalLogger.render_error("              ")
        puts TerminalLogger.render_error("(╯°□°)╯︵ ┻━┻ ")
        puts TerminalLogger.render_error("              ")
        puts "\n"
        puts TerminalLogger.render_error("Нет, ты ошибся!")
      end

      break
    else
      puts "Ответ только A - D"
    end
  end  
end

File.write(
  "#{current_path}/#{file_name}", 
  "#{current_time}\n\nРезультаты пользователя #{user_name}\n\nПравильных ответов: #{correct_answers_count}\nНеправильных ответов: #{incorrect_answers_count}",
  mode: 'a'
  )
