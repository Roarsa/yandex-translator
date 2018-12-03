require "test_helper"

class Yandex::TranslatorTest < Minitest::Test
  API_KEY = "trnsl.1.1.20181119T190750Z.cef13c0375be00d6.0003118ac368c328c4913ee1671b3e129583469a"

	def test_get_languages
		test = Yandex::GetLanguages.new(API_KEY).main('ru')
		assert test['dirs'].is_a?(Array)
		assert test['langs'].is_a?(Hash)
	end

	def test_define_language
		test = Yandex::DefineLang.new(API_KEY).main('Hello World!')
		assert_equal 'en', test
	end

	def test_translate_text
		test = Yandex::TranslateText.new(API_KEY).main('Hello World!', 'ru')
		assert_equal 'Всем Привет!', test
	end

	def test_translate_text_with_lang
		test = Yandex::TranslateText.new(API_KEY).main('Hello World!', 'ru', 'en')
		assert_equal 'Всем Привет!', test
	end
end
