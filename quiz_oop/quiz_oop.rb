require 'yaml'

require_relative '../utils/terminal_logger'
require_relative 'class_file_writer'
require_relative 'class_questions'

a_code = 'A'.ord

puts "Введите ваше имя:"
user_name = gets.strip

current_path = File.dirname(__FILE__)

all_questions = Questions.new "#{current_path}/questions.yml"

all_questions.load.shuffle.each do |item|

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
        all_questions.add_correct_answer_count

        puts TerminalLogger.render_success("           ")
        puts TerminalLogger.render_success("＼(★^∀^★)／")
        puts TerminalLogger.render_success("           ")
        puts "\n"
        puts TerminalLogger.render_success("Да!!! Это правильный ответ!")
      else
        all_questions.add_incorrect_answer_count

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

current_time = Time.now.strftime('%d-%m-%Y_%H-%M-%S')
file_name = "#{current_path}/QUIZ_#{user_name}_#{current_time}.txt"

file_writer = FileWriter.new file_name, 'a'

file_writer.write "#{current_time}\n
\nРезультаты пользователя #{user_name}\n
\nПравильных ответов: #{all_questions.correct_answers_count}\n
Неправильных ответов: #{all_questions.incorrect_answers_count}"
