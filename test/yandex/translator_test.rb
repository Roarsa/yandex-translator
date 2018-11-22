require "test_helper"

class Yandex::TranslatorTest < Minitest::Test
  API_KEY = "trnsl.1.1.20181119T190750Z.cef13c0375be00d6.0003118ac368c328c4913ee1671b3e129583469a"

	def test_get_languages
		test = Yandex::Translator.new(API_KEY).get_languages('ru')
		assert test['dirs'].is_a?(Array)
		assert test['langs'].is_a?(Hash)
	end

	def test_define_language
		test = Yandex::Translator.new(API_KEY).define_languages('Hello World!')
		assert_equal 'en', test
	end

	def test_translate_text
		test = Yandex::Translator.new(API_KEY).translate_text('Hello World!', 'ru')
		assert_equal 'Всем Привет!', test
	end

	def test_translate_text_with_lang
		test = Yandex::Translator.new(API_KEY).translate_text('Hello World!', 'ru', 'en')
		assert_equal 'Всем Привет!', test
	end
end
