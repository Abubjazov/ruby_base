# frozen_string_literal: true

require_relative 'character'
require_relative '../../utils/terminal_logger'

# Класс персонажа Hero
class Hero < Character
  attr_reader :health_potions, :potion_strength

  def initialize
    super(min_dmg: 1, max_dmg: 5, hit_points: 20, character_type: 'вас')
  end

  def post_initialize
    @health_potions  = 5
    @potion_strength = 10
  end

  def dead?
    @hit_points <= 0
  end

  def attack(target)
    dmg = super

    puts TerminalLogger.render_success("Вы атаковали #{target.character_type} и нанесли урон #{dmg}")
    puts TerminalLogger.render_success("У #{target.character_type} осталось здоровья #{target.hit_points}")
    puts "\n"
  end

  def drink_potion
    return unless @health_potions.positive?

    @hit_points = (@hit_points + @potion_strength).clamp(0, @max_hit_points)
    @health_potions -= 1

    print_drink_potion_result
  end

  def print_drink_potion_result
    puts TerminalLogger.render_success('Вы выпили зелье здоровья!')
    puts TerminalLogger.render_success("У вас осталось #{@health_potions} зелье здоровья")
    puts TerminalLogger.render_success("Зелье прибавило вам здоровья на  #{@potion_strength}")
    puts TerminalLogger.render_success("Ваше здоровье сейчас  #{@hit_points}")
    puts "\n"
  end
end
