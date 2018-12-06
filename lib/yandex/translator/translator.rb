require "net/http"
require "uri"
require "json"

module YandexTranslator
    class ApiError < StandardError
    end

    class Translator
        def initialize(api_key)
            @api_key = api_key
            @api_url = "https://translate.yandex.net/api/v1.5/tr.json"
        end

        def post(ui, parameters) 
          response = Net::HTTP.post_form(ui, parameters)
          if response.code == "200"
              JSON.parse(response.body)
          else
              raise ApiError.new(JSON.parse(response.body)["message"])
          end
        end
    end    
end