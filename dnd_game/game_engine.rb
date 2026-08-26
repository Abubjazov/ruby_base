# frozen_string_literal: true

require 'io/console'

require_relative 'classes/dragon'
require_relative 'classes/hero'
require_relative '../utils/terminal_logger'

# Класс для движка игры
class Engine
  def initialize
    @hero = Hero.new
    @dragon = Dragon.new
    @hero_turn = true
  end

  def run
    loop do
      if @hero_turn
        execute_hero_turn
      else
        execute_dragon_turn
      end

      break if game_over?
    end

    announce_winner
  end

  private

  def game_over?
    @hero.dead? || @dragon.dead?
  end

  def announce_winner
    if @hero.dead?
      handle_failure
    else
      handle_success
    end
  end

  def handle_success
    puts TerminalLogger.render_success('           ')
    puts TerminalLogger.render_success('＼(★^∀^★)／')
    puts TerminalLogger.render_success('           ')
    puts "\n"
    puts TerminalLogger.render_success('Да!!! Вы победили!')
  end

  def handle_failure
    puts TerminalLogger.render_error('              ')
    puts TerminalLogger.render_error('(╯°□°)╯︵ ┻━┻ ')
    puts TerminalLogger.render_error('              ')
    puts "\n"
    puts TerminalLogger.render_error('О нет, Дракон победил...')
  end

  def execute_hero_turn
    @hero_turn = false
    show_hero_menu
    action = read_player_action
    handle_action(action)
  end

  def execute_dragon_turn
    @hero_turn = true
    @dragon.attack(@hero)
  end

  def handle_action(action)
    return drink_potion_if_possible if action == 'A'

    @hero.attack(@dragon) if action == 'D'
  end

  def show_hero_menu
    menu_options = ['Ваши действия?']
    menu_options << 'Выпить зелье - нажмите A' if @hero.health_potions.positive?
    menu_options << 'Атаковать противника - нажмите D'

    puts menu_options.join("\n")
  end

  KEY_MAPPING = {
    65 => 'A', 1060 => 'A', # A, Ф
    68 => 'D', 1042 => 'D'  # D, В
  }.freeze

  def read_player_action
    loop do
      char = $stdin.getch
      next if char.nil?

      char_upcase = char.to_s.upcase
      code = char_upcase.ord

      return KEY_MAPPING[code] if KEY_MAPPING.key?(code)

      handle_invalid_input(char)
    end
  end

  def handle_invalid_input(char)
    input_text = [13, 10].include?(char.ord) ? 'Enter' : char.strip
    puts "\nОжидаются только A или D! Вы ввели: #{input_text.empty? ? 'Space/Blank' : input_text}"
  end

  def drink_potion_if_possible
    @hero.drink_potion if @hero.health_potions.positive?
  end
end
