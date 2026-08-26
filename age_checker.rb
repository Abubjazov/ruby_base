require_relative 'utils/terminal_logger'

ACCESS_GRANTED = TerminalLogger.render_success('ACCESS GRANTED')
ACCESS_DENIED = TerminalLogger.render_error('ACCESS DENIED')

country_rules = Hash.new(18)

country_rules['JAPAN'] = 21
country_rules['USA']   = 21

# puts "Содержимое хеша: #{country_rules}"
# puts "Значение по умолчанию: #{country_rules.default}"

puts 'Введите ваш возраст!'
user_age = gets.to_i

puts 'Введите вашу страну: '
user_country = gets.strip.upcase

coutry_allowed_age = country_rules[user_country]
access_allowed = user_age >= coutry_allowed_age

if access_allowed
  puts ACCESS_GRANTED
else
  puts ACCESS_DENIED
end

puts access_allowed ? ACCESS_GRANTED : ACCESS_DENIED

puts ACCESS_GRANTED if access_allowed
puts ACCESS_DENIED unless access_allowed
