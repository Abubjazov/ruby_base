# frozen_string_literal: true

# Вывод цветного текста в терминал
module TerminalLogger
  def self.render_error(text)
    "\e[37;41m #{text} \e[0m"
  end

  def self.render_success(text)
    "\e[30;42m #{text} \e[0m"
  end

  def self.render_gray_text(text)
    "\e[90m #{text} \e[0m"
  end
end
