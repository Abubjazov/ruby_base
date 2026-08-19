require 'dotenv'
require 'faraday'

require_relative '../utils/terminal_logger'
require_relative '../utils/time_utils'
require_relative 'open_weather_api_client'

Dotenv.load

api_key = ENV['OPENWEATHER_API_KEY']
abort "Ошибка: Переменная OPENWEATHER_API_KEY не найдена! Проверьте файл .env" if api_key.nil? || api_key.empty? 

base_url = ENV['OPENWEATHER_API_BASE_URL']
abort "Ошибка: Переменная OPENWEATHER_API_KEY не найдена! Проверьте файл .env" if api_key.nil? || api_key.empty? 

# Координаты Казани
latitude = 55.7887
longitude = 49.1221

client = OpenWeatherApiClient.new(base_url, api_key)

puts "\n\n"
puts "Отправляем запрос погоды для Казани..."
puts "\n\n"

weather_data = client.current_weather(latitude, longitude)

if weather_data && weather_data['cod'] == 200

  # Локальные переменные для удобства
  main = weather_data['main']
  wind = weather_data['wind']
  sys = weather_data['sys']
  weather = weather_data['weather']&.first || {}
  offset = weather_data['timezone']

  # 2. Красивый вывод в консоль
  puts TerminalLogger.render_success("======== ПОГОДА В ГОРОДЕ: #{weather_data['name']} (#{sys['country']}) ========")
  puts "\n"
  puts "Координаты:      Широта #{weather_data['coord']['lat']}, Долгота #{weather_data['coord']['lon']}"
  puts "Время замера:    #{format_time(weather_data['dt'], offset)}"
  puts "\n"
  puts TerminalLogger.render_success("=" * 46)
  puts "\n"

  # Погода и температура (вывод значений напрямую)
  puts "Состояние:       #{weather['main']} (#{weather['description']})"
  puts "Температура:     #{main['temp']}°C"
  puts "Ощущается как:   #{main['feels_like']}°C"
  puts "Мин / Макс:      #{main['temp_min']}°C / #{main['temp_max']}°C"
  
  puts "-" * 46

  # Атмосферные показатели
  puts "Давление:        #{main['pressure']} гПа (на уровне моря: #{main['sea_level']} гПа)"
  puts "Влажность:       #{main['humidity']}%"
  puts "Облачность:      #{weather_data['clouds']['all']}%"
  puts "Видимость:       #{weather_data['visibility']} метров"

  # Осадки (если есть ключ rain)
  if weather_data['rain'] && weather_data['rain']['1h']
    puts "Осадки (за 1ч):  #{weather_data['rain']['1h']} мм"
  end

  # Ветер
  gust_info = wind['gust'] ? ", порывы до #{wind['gust']} м/с" : ""
  puts "Ветер:           #{wind['speed']} м/с, направление #{wind['deg']}°#{gust_info}"

  puts "-" * 45

  # Астрономия (время местное для указанной зоны)
  puts "Восход солнца:   #{format_time(sys['sunrise'], offset)}"
  puts "Закат солнца:    #{format_time(sys['sunset'], offset)}"
  puts "\n"
  puts TerminalLogger.render_success("=" * 45)
  puts "\n\n"
  
else

  puts TerminalLogger.render_error("Ошибка API: #{weather_data['message']}")

end
