# frozen_string_literal: true

require_relative '../utils/terminal_logger'
require_relative 'class_file_writer'
require_relative 'class_questions_data'

# Класс для движка игры
class Engine
  attr_reader :correct_answers_count, :incorrect_answers_count

  def initialize
    @user_name = user_name
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

    file_writer = FileWriter.new @user_name

    file_writer.write "Результаты пользователя #{@user_name}\n\n" \
    "Правильных ответов: #{@correct_answers_count}\n" \
    "Неправильных ответов: #{@incorrect_answers_count}"
  end

  private

  def user_name
    puts 'Введите ваше имя:'
    gets.strip
  end

  def add_correct_answer_count
    @correct_answers_count += 1
  end

  def add_incorrect_answer_count
    @incorrect_answers_count += 1
  end

  def compare_answers(answers, correct_answer) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    loop do
      puts 'Введите ваш ответ:'
      user_answer = gets.strip[0].upcase

      if user_answer.between?('A', 'D')
        user_answer = answers[user_answer]

        answer_correct = user_answer == correct_answer

        if answer_correct
          add_correct_answer_count

          puts TerminalLogger.render_success('           ')
          puts TerminalLogger.render_success('＼(★^∀^★)／')
          puts TerminalLogger.render_success('           ')
          puts "\n"
          puts TerminalLogger.render_success('Да!!! Это правильный ответ!')
        else
          add_incorrect_answer_count

          puts TerminalLogger.render_error('              ')
          puts TerminalLogger.render_error('(╯°□°)╯︵ ┻━┻ ')
          puts TerminalLogger.render_error('              ')
          puts "\n"
          puts TerminalLogger.render_error('Нет, ты ошибся!')
        end

        break
      else
        puts 'Ответ только A - D'
      end
    end
  end
end
