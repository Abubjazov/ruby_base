# frozen_string_literal: true

require_relative 'classes/dragon'
require_relative 'classes/hero'
require_relative 'classes/game_console'
require_relative 'classes/game_renderer'

# Игровой движок, управляющий бизнес-логикой
class Engine
  def initialize
    @hero = Hero.new
    @dragon = Dragon.new
    @hero_turn = true
  end

  def run
    loop do
      @hero_turn ? execute_hero_turn : execute_dragon_turn
      break if game_over?
    end

    GameRenderer.announce_winner(@hero)
  end

  private

  def game_over?
    @hero.dead? || @dragon.dead?
  end

  def execute_hero_turn
    @hero_turn = false
    GameRenderer.show_menu(@hero)

    action = GameConsole.read_player_action
    handle_action(action)
  end

  def execute_dragon_turn
    @hero_turn = true
    @dragon.attack(@hero)
  end

  def handle_action(action)
    case action
    when 'A' then drink_potion_if_possible
    when 'D' then @hero.attack(@dragon)
    end
  end

  def drink_potion_if_possible
    @hero.drink_potion if @hero.health_potions.positive?
  end
end
