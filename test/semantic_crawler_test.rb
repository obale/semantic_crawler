require 'test_helper'

class SemanticCrawlerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, SemanticCrawler
  end

  test "get austria country information" do
      austria = SemanticCrawler::Freebase::FreebaseCrawler.new
      countryObj = austria.getCountry("Austria")
      countryNameNormalized = countryObj.input_name
      assert countryNameNormalized.eql?("austria")
  end

  test "get empty crawler object" do
      empty = SemanticCrawler::Freebase::FreebaseCrawler.new
      assert !empty.nil?
  end

end
