# frozen_string_literal: true

# Класс для чтения ввода с клавиатуры
class InputReader
  def read(msg: nil, validator: nil, err_msg: nil, process: nil)
    puts msg if msg

    value = gets.strip

    if validator.nil? || validator.call(value)
      process ? process.call(value) : value
    else
      puts err_msg if err_msg
      read(msg: msg, validator: validator, err_msg: err_msg, process: process)
    end
  end
end
