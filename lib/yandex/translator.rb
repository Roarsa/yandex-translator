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

        def post(ui, parameters) 
          response = Net::HTTP.post_form(ui, parameters)
          if response.code == "200"
              JSON.parse(response.body)
          else
              raise ApiError.new(JSON.parse(response.body)["message"])
          end
        end
    end

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

    class TranslateText < Translator
      def uri
        URI.parse("#{@api_url}/translate?key=#{@api_key}&")
      end

      def main(text, final_lang, lang=nil,format='plain')
          language = lang ? "#{lang}-#{final_lang}" : final_lang
          parameters =  {"text" => text, "lang" => language, "format" => format}
          post(uri(), parameters)["text"][0]
      end
    end

    class DefineLang < Translator
      def uri
        URI.parse("#{@api_url}/detect?key=#{@api_key}&")
      end

      def main(text, hint='')
          parameters =  {"text" => text, "hint" => hint}
          post(uri(), parameters)["lang"]
      end
    end
end