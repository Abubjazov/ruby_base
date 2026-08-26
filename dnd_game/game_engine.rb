# frozen_string_literal: true

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

  def read_player_action
    gets.to_s.strip[0].to_s.upcase
  end

  def drink_potion_if_possible
    @hero.drink_potion if @hero.health_potions.positive?
  end
end
