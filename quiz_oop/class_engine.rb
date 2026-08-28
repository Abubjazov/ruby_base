# frozen_string_literal: true

require_relative '../utils/terminal_logger'
require_relative 'class_file_writer'
require_relative 'class_questions_data'
require_relative 'class_input_reader'

# Класс для движка игры
class Engine
  attr_reader :correct_answers_count, :incorrect_answers_count

  def initialize
    @input_reader = InputReader.new
    @user_name = @input_reader.read msg: 'Введите ваше имя:',
                                    validator: ->(value) { !value.empty? },
                                    err_msg: 'Имя не может быть пустым!'
    @question_data = QuestionsData.new
    @file_writer = FileWriter.new @user_name
    @correct_answers_count = 0
    @incorrect_answers_count = 0
  end

  def run
    @question_data.collection.each do |next_question|
      puts next_question.question
      next_question.display_answers

      compare_answers next_question.answers, next_question.correct_answer
    end

    @file_writer.write "Результаты пользователя #{@user_name}\n\n" \
    "Правильных ответов: #{@correct_answers_count}\n" \
    "Неправильных ответов: #{@incorrect_answers_count}"
  end

  private

  def add_correct_answer_count
    @correct_answers_count += 1
  end

  def add_incorrect_answer_count
    @incorrect_answers_count += 1
  end

  def compare_answers(answers, correct_answer)
    user_answer = ask_valid_answer(answers)

    if user_answer == correct_answer
      handle_success
    else
      handle_failure
    end
  end

  def ask_valid_answer(answers)
    user_input = @input_reader.read msg: 'Введите ваш ответ:',
                                    validator: ->(value) { !value.empty? && value.strip[0].upcase.between?('A', 'D') },
                                    err_msg: 'Ответ только A - D',
                                    process: ->(value) { value.strip[0].upcase }

    answers[user_input]
  end

  def handle_success
    add_correct_answer_count

    puts TerminalLogger.render_success('           ')
    puts TerminalLogger.render_success('＼(★^∀^★)／')
    puts TerminalLogger.render_success('           ')
    puts "\n"
    puts TerminalLogger.render_success('Да!!! Это правильный ответ!')
  end

  def handle_failure
    add_incorrect_answer_count

    puts TerminalLogger.render_error('              ')
    puts TerminalLogger.render_error('(╯°□°)╯︵ ┻━┻ ')
    puts TerminalLogger.render_error('              ')
    puts "\n"
    puts TerminalLogger.render_error('Нет, ты ошибся!')
  end
end
