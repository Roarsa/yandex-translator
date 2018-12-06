require_relative './translator'

module YandexTranslator
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
end