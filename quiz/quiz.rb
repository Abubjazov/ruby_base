require 'yaml'

require_relative '../utils/terminal_logger'

a_code = 'A'.ord

puts 'Введите ваше имя:'
user_name = gets.strip
current_time = Time.now.strftime('%d-%m-%Y_%H-%M-%S')
file_name = "QUIZ_#{user_name}_#{current_time}.txt"

current_path = File.dirname(__FILE__)
all_questions = YAML.safe_load_file("#{current_path}/questions.yml", symbolize_names: true)

correct_answers_count = 0
incorrect_answers_count = 0

def display_question(question_text)
  puts "\n\n"
  header_text = ">>>>>>>  #{question_text}  <<<<<<<"
  padding = ' ' * header_text.length

  puts TerminalLogger.render_success(padding)
  puts TerminalLogger.render_success(header_text)
  puts TerminalLogger.render_success(padding)
  puts "\n"
end

def prepare_and_display_answers(raw_answers)
  a_code = 'A'.ord

  processed_answers = raw_answers.shuffle.each_with_index.each_with_object({}) do |(answer, i), result|
    answer_char = (a_code + i).chr
    result[answer_char] = answer
    puts "#{answer_char}. #{answer}"
  end

  puts "\n"
  processed_answers
end

def ask_and_check_answer(answers, correct_answer)
  user_answer = ask_valid_letter

  if answers[user_answer] == correct_answer
    handle_correct_choice
  else
    handle_incorrect_choice
  end
end

def ask_valid_letter
  loop do
    puts 'Введите ваш ответ:'
    input = gets.strip[0]&.upcase

    return input if input&.between?('A', 'D')

    puts 'Ответ только A - D'
  end
end

def handle_correct_choice
  @correct_answers_count = (@correct_answers_count || 0) + 1 # или просто correct_answers_count += 1, если это локальная переменная вне методов (тогда передайте её по ссылке/сделайте глобальной)

  puts TerminalLogger.render_success('           ')
  puts TerminalLogger.render_success('＼(★^∀^★)／')
  puts TerminalLogger.render_success('           ')
  puts "\n"
  puts TerminalLogger.render_success('Да!!! Это правильный ответ!')
end

def handle_incorrect_choice
  @incorrect_answers_count = (@incorrect_answers_count || 0) + 1

  puts TerminalLogger.render_error('              ')
  puts TerminalLogger.render_error('(╯°□°)╯︵ ┻━┻ ')
  puts TerminalLogger.render_error('              ')
  puts "\n"
  puts TerminalLogger.render_error('Нет, ты ошибся!')
end

all_questions.shuffle.each do |item|
  display_question(item[:question])
  answers = prepare_and_display_answers(item[:answers])
  ask_and_check_answer(answers, item[:correct_answer])
end

File.write(
  "#{current_path}/#{file_name}",
  "#{current_time}\n\nРезультаты пользователя #{user_name}\n\nПравильных ответов: #{correct_answers_count}\nНеправильных ответов: #{incorrect_answers_count}",
  mode: 'a'
)
