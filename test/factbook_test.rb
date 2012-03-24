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
end
