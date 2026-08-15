module TerminalLogger
  def self.render_error(text)
    "\e[37;41m #{text} \e[0m"
  end

  def self.render_success(text)
    "\e[30;42m #{text} \e[0m"
  end
end