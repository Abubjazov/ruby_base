# frozen_string_literal: true

require 'io/console'

# Отвечает за низкоуровневое чтение ввода с клавиатуры
class GameConsole
  KEY_MAPPING = {
    65 => 'A', 1060 => 'A', # A, Ф
    68 => 'D', 1042 => 'D'  # D, В
  }.freeze

  def self.read_player_action
    loop do
      char = $stdin.getch
      next if char.nil?

      code = char.to_s.upcase.ord
      return KEY_MAPPING[code] if KEY_MAPPING.key?(code)

      GameRenderer.show_invalid_input(char)
    end
  end
end
