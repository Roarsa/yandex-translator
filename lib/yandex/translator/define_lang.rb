require_relative './translator'

module YandexTranslator
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