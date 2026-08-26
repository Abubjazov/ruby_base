# frozen_string_literal: true

# Класс для работы с данными вопроса викторины
class Question
  attr_reader :question, :correct_answer, :answers

  A_CODE = 'A'.ord

  def initialize(question, answers, correct_answer)
    @question = prepare_question question
    @correct_answer = correct_answer
    @answers = prepare_answers answers
  end

  def display_answers
    puts "\n"
    @answers.each do |answer_char, answer|
      puts "#{answer_char}. #{answer}"
    end
    puts "\n"
  end

  private

  def prepare_question(question)
    header_text = ">>>>>>>  #{question}  <<<<<<<"
    padding = ' ' * header_text.length

    "\n\n#{[padding, header_text, padding].map { |str| TerminalLogger.render_success(str) }.join("\n")}\n"
  end

  def prepare_answers(answers)
    answers.shuffle.each_with_index.each_with_object({}) do |(answer, i), result|
      answer_char = (A_CODE + i).chr

      result[answer_char] = answer

      result
    end
  end
end
