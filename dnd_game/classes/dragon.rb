# frozen_string_literal: true

require_relative 'character'

# Класс персонажа Dragon
class Dragon < Character
  def initialize
    super(min_dmg: 1, max_dmg: 7, hit_points: 30, character_type: 'Дракона')
  end

  def dead?
    @hit_points <= 0
  end

  def attack(target)
    dmg = super

    puts TerminalLogger.render_error("Дракон атакует #{target.character_type} и наносит урон #{dmg}")
    puts TerminalLogger.render_error("У #{target.character_type} осталось здоровья #{target.hit_points}")
    puts "\n"
  end
end
