require 'test_helper'
require 'pp'

class FactbookTest < ActiveSupport::TestCase
    test "truth" do
        assert_kind_of Module, SemanticCrawler
    end

    test "init austria country information" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        assert austria.country_name.eql?("austria")
        assert austria.url.eql?("http://www4.wiwiss.fu-berlin.de/factbook/data/austria")
    end

    test "get austria name" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.name
        assert value.to_s.eql?("Austria")
    end

    test "get austria background information" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.background
        assert !value.nil?
    end

    test "get austria population information" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.population_total
        assert !value.nil?
    end

    test "get austria legalsystem property (not wrapped)" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.get_factbook_property("legalsystem")
        assert !value.nil?
    end

    test "get austria latitude" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.latitude
        assert value.to_s.eql?("47.3333333333333")
    end

    test "get austria longitude" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.longitude
        assert value.to_s.eql?("13.3333333333333")
    end

    test "get austria landboundary" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.landboundary
        assert value.count == 7
    end

    test "get austria terrain" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.terrain
        assert !value.nil?
    end

    test "get austria total airports" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.airports_total
        assert value.to_s.eql?("55")
    end

    test "get austria climate" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.climate
        assert !value.nil?
    end

    test "get austria location description" do
        austria = SemanticCrawler::Factbook::Country.new("Austria")
        value = austria.location
        assert !value.nil?
    end
end
