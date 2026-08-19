require 'time'
# Функция для конвертации Unix Timestamp в читаемую строку времени
def format_time(timestamp, timezone_offset)
  Time.at(timestamp).utc.getlocal(timezone_offset).strftime('%Y-%m-%d %H:%M:%S')
end