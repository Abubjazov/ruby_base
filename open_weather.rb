require 'dotenv'
require 'faraday'
# require 'net/http'
require 'json'
require 'time'
require_relative 'terminal_logger'

Dotenv.load

api_key = ENV['OPENWEATHER_API_KEY']
abort "Ошибка: Переменная OPENWEATHER_API_KEY не найдена! Проверьте файл .env" if api_key.nil? || api_key.empty? 

base_url = ENV['OPENWEATHER_API_BASE_URL']
abort "Ошибка: Переменная OPENWEATHER_API_KEY не найдена! Проверьте файл .env" if api_key.nil? || api_key.empty? 

# Координаты Казани
latitude = 55.7887
longitude = 49.1221

query_params = {
  lat: latitude,
  lon: longitude,
  units: :metric,
  lang: :ru,
  appid: api_key,
}

# URL_STRING = "#{base_url}?lat=#{latitude}&lon=#{longitude}&units=metric&lang=ru&appid=#{api_key}"
# REQ_URI = URI(URL_STRING) #'net/http'


puts "Отправляем запрос погоды для Казани..."
puts "\n\n"

# response = Net::HTTP.get(REQ_URI) #'net/http'
# parsed_data = JSON.parse(response) #'net/http'
# 
response = Faraday.get(base_url, query_params)
parsed_data = JSON.parse(response.body)

# Функция для конвертации Unix Timestamp в читаемую строку времени
def format_time(timestamp, timezone_offset)
  Time.at(timestamp).utc.getlocal(timezone_offset).strftime('%Y-%m-%d %H:%M:%S')
end

# Проверяем успешность ответа
if parsed_data['cod'] == 200
  # Локальные переменные для удобства
  main = parsed_data['main']
  wind = parsed_data['wind']
  sys = parsed_data['sys']
  weather = parsed_data['weather']&.first || {}
  offset = parsed_data['timezone']

  # 2. Красивый вывод в консоль
  puts TerminalLogger.render_success("======== ПОГОДА В ГОРОДЕ: #{parsed_data['name']} (#{sys['country']}) ========")
  puts "\n"
  puts "Координаты:      Широта #{parsed_data['coord']['lat']}, Долгота #{parsed_data['coord']['lon']}"
  puts "Время замера:    #{format_time(parsed_data['dt'], offset)}"
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
  puts "Облачность:      #{parsed_data['clouds']['all']}%"
  puts "Видимость:       #{parsed_data['visibility']} метров"

  # Осадки (если есть ключ rain)
  if parsed_data['rain'] && parsed_data['rain']['1h']
    puts "Осадки (за 1ч):  #{parsed_data['rain']['1h']} мм"
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
else
  puts TerminalLogger.render_error("Ошибка API: #{parsed_data['message']}")
end