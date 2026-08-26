# frozen_string_literal: true

# Класс для записи файла
class FileWriter
  def initialize(user_name, mode = 'a')
    @filename = gen_filename user_name
    @mode = mode
  end

  def gen_filename(user_name)
    current_path = File.dirname(__FILE__)
    current_time = Time.now.strftime('%d-%m-%Y_%H-%M-%S')

    "#{current_path}/QUIZ_#{user_name}_#{current_time}.txt"
  end

  def write(content)
    File.write(
      @filename,
      content,
      mode: @mode
    )
  end
end
