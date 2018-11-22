require "net/http"
require "uri"
require "json"

module Yandex
  
 	class ApiError < StandardError
 	end

	class Translator
		def initialize(api_key)
			@api_key = api_key
		end

		def get_languages(ui)
			uri = URI.parse("https://translate.yandex.net/api/v1.5/tr.json/getLangs?key=#{@api_key}&ui=#{ui}")
			response = Net::HTTP.get(uri)
			if JSON.parse(response)["code"] == 401 || JSON.parse(response)["code"] == 402
				raise ApiError.new(JSON.parse(response)["message"])
			else
				JSON.parse(response)
			end
		end

		def define_languages(text, hint='')
			uri = URI.parse("https://translate.yandex.net/api/v1.5/tr.json/detect?key=#{@api_key}&")
			parameters =  {"text" => text, "hint" => hint}
			response = Net::HTTP.post_form(uri, parameters)
			if response.code== "200"
				JSON.parse(response.body)["lang"]
			else
				raise ApiError.new(JSON.parse(response.body)["message"])
			end
		end

		def translate_text(text, final_lang, lang=nil,format='plain')
			uri = URI.parse("https://translate.yandex.net/api/v1.5/tr.json/translate?key=#{@api_key}&")
			language = lang ? "#{lang}-#{final_lang}" : final_lang
			parameters =  {"text" => text, "lang" => language, "format" => format}
			response = Net::HTTP.post_form(uri, parameters)
			if response.code == "200"
				JSON.parse(response.body)["text"][0]
			else
				raise ApiError.new(JSON.parse(response.body)["message"])
			end
		end
	end
end
