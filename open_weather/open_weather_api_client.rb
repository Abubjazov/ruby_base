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
      appid: @api_key,
    }
    # Выполняем запрос к эндпоинту
    response = @connection.get('', query_params)
    
    # Возвращаем тело ответа, если HTTP-статус в диапазоне 200-299
    return response.body if response.success?
    
    nil
  rescue Faraday::ConnectionFailed => e
    # Ошибка: сервер недоступен, упал интернет или неверный домен (DNS)
    puts "Ошибка подключения: #{e.message}"
    nil
  rescue Faraday::TimeoutError => e
    # Ошибка: сервер слишком долго не отвечал
    puts "Превышено время ожидания ответа: #{e.message}"
    nil
  rescue Faraday::Error => e
    # Общая подстраховка для любых других ошибок Faraday
    puts "Произошла непредвиденная ошибка Faraday: #{e.message}"
    nil
  end
  
end