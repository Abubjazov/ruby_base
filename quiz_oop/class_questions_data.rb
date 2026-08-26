# frozen_string_literal: true

require 'yaml'

require_relative 'class_question'

# Класс для работы с данными вопросов викторины
class QuestionsData
  attr_reader :correct_answers_count, :incorrect_answers_count, :collection

  def initialize
    @filename = "#{File.dirname(__FILE__)}/questions.yml"

    @collection = load
  end

  private

  def load
    raw_data = YAML.safe_load_file(@filename, symbolize_names: true)

    raw_data.shuffle.map do |q_data|
      Question.new(q_data[:question], q_data[:answers], q_data[:correct_answer])
    end
  end
end
