# frozen_string_literal: true

# Класс для движка игры
class Character
  attr_reader :max_hit_points, :hit_points, :character_type

  def initialize(min_dmg:, max_dmg:, hit_points:, character_type:)
    @max_hit_points = hit_points.freeze
    @hit_points = hit_points
    @min_dmg = min_dmg
    @max_dmg = max_dmg
    @character_type = character_type

    post_initialize
  end

  def post_initialize; end

  def attack(target)
    dmg = rand @min_dmg..@max_dmg
    target.receive_dmg dmg

    dmg
  end

  protected

  def receive_dmg(dmg)
    @hit_points -= dmg
  end
end
