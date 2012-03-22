require 'test_helper'
require 'pp'

class SemanticCrawlerTest < ActiveSupport::TestCase
    test "truth" do
        assert_kind_of Module, SemanticCrawler
    end

    test "init austria country information" do
        austria = SemanticCrawler::Freebase::Crawler.new
        countryObj = austria.getCountry("Austria")
        countryNameNormalized = countryObj.input_name
        assert countryNameNormalized.eql?("austria")
    end

    test "get austria country information" do
        austria = SemanticCrawler::Freebase::Crawler.new
        countryObj = austria.getCountry("Austria")
        pp countryObj.get["properties"]["/location/statistical_region/population"]
    end

    test "get empty crawler object" do
        empty = SemanticCrawler::Freebase::Crawler.new
        assert !empty.nil?
    end

end
