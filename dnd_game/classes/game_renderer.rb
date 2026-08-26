# frozen_string_literal: true

require_relative '../../utils/terminal_logger'

# Отвечает за отрисовку интерфейса и сообщений игры
class GameRenderer
  def self.show_menu(hero)
    menu_options = ['Ваши действия?']
    menu_options << 'Выпить зелье - нажмите A' if hero.health_potions.positive?
    menu_options << 'Атаковать противника - нажмите D'
    puts menu_options.join("\n")
  end

  def self.announce_winner(hero)
    hero.dead? ? render_failure : render_success
  end

  def self.render_success
    puts TerminalLogger.render_success(' ')
    puts TerminalLogger.render_success('＼(★^∀^★)／')
    puts TerminalLogger.render_success(' ')
    puts "\n"
    puts TerminalLogger.render_success('Да!!! Вы победили!')
  end

  def self.render_failure
    puts TerminalLogger.render_error(' ')
    puts TerminalLogger.render_error('(╯°□°)╯︵ ┻━┻ ')
    puts TerminalLogger.render_error(' ')
    puts "\n"
    puts TerminalLogger.render_error('О нет, Дракон победил...')
  end

  def self.show_invalid_input(char)
    input_text = [13, 10].include?(char.ord) ? 'Enter' : char.strip
    display_char = input_text.empty? ? 'Space/Blank' : input_text
    puts "\nОжидаются только A или D! Вы ввели: #{display_char}"
  end
end
