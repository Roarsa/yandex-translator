require_relative './translator'

module YandexTranslator
  class GetLanguages < Translator
    def uri(ui)
      URI.parse("#{@api_url}/getLangs?key=#{@api_key}&ui=#{ui}")
    end

    def main(ui)
      response = Net::HTTP.get(uri(ui))
      if JSON.parse(response)["code"] == 401 || JSON.parse(response)["code"] == 402
        raise ApiError.new(JSON.parse(response)["message"])
      else
        JSON.parse(response)
      end
    end
  end   
end