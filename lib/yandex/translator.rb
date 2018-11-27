require "net/http"
require "uri"
require "json"

module Yandex
  
    class ApiError < StandardError
    end

    class Translator
        def initialize(api_key)
            @api_key = api_key
            @api_url = "https://translate.yandex.net/api/v1.5/tr.json"
        end

        def uri(method, ui = '') 
          case method
          when 'getLangs'
            URI.parse("#{@api_url}/#{method}?key=#{@api_key}&ui=#{ui}")
          else
            URI.parse("#{@api_url}/#{method}?key=#{@api_key}&")
          end
        end

        def post(ui, parameters) 
          response = Net::HTTP.post_form(ui, parameters)
          if response.code == "200"
              JSON.parse(response.body)
          else
              raise ApiError.new(JSON.parse(response.body)["message"])
          end
        end

        def get_languages(ui)
            response = Net::HTTP.get(uri('getLangs', ui))
            if JSON.parse(response)["code"] == 401 || JSON.parse(response)["code"] == 402
                raise ApiError.new(JSON.parse(response)["message"])
            else
                JSON.parse(response)
            end
        end

        def define_languages(text, hint='')
            parameters =  {"text" => text, "hint" => hint}
            post(uri('detect'), parameters)["lang"]
        end

        def translate_text(text, final_lang, lang=nil,format='plain')
            language = lang ? "#{lang}-#{final_lang}" : final_lang
            parameters =  {"text" => text, "lang" => language, "format" => format}
            post(uri('translate'), parameters)["text"][0]
        end
    end
end