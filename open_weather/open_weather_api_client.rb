# frozen_string_literal: true

# класс для работы с API Open Weather
class OpenWeatherApiClient
  def initialize(base_url, api_key)
    @base_url = base_url
    @api_key = api_key

    @connection = Faraday.new(url: base_url) do |f|
      f.request :json
      f.response :json
    end
  end

  def current_weather(latitude, longitude)
    query_params = {
      lat: latitude,
      lon: longitude,
      units: :metric,
      lang: :ru,
      appid: @api_key
    }

    fetch_weather_data(query_params)
  end

  private

  def fetch_weather_data(params)
    response = @connection.get('', params)
    response.body if response.success?
  rescue Faraday::ConnectionFailed => e
    log_error('Ошибка подключения', e)
  rescue Faraday::TimeoutError => e
    log_error('Превышено время ожидания ответа', e)
  rescue Faraday::Error => e
    log_error('Произошла непредвиденная ошибка Faraday', e)
  end

  def log_error(message, error)
    puts "#{message}: #{error.message}"
    nil
  end
end
