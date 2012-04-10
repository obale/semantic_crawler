require 'spec_helper'

describe SemanticCrawler::Factbook do

    before(:all) do
        @austria = SemanticCrawler::Factbook::Country.new("Austria")
    end

    it "test nil country" do
        wrongCountry = SemanticCrawler::Factbook::Country.new(nil)
        wrongCountry.url.nil?.should == true
    end

    it "test unknown country" do
        wrongCountry = SemanticCrawler::Factbook::Country.new("xyz")
        wrongCountry.landboundary.nil?.should == true
        wrongCountry.background.nil?.should == true
        wrongCountry.name.nil?.should == true
    end

    it "init austria country information" do
        be_valid @austria.country_name.eql?("Austria")
        be_valid @austria.url.eql?("http://www4.wiwiss.fu-berlin.de/factbook/data/austria")
    end

    it "get doc dump" do
        be_valid !@austria.xml_document.empty?
    end

    it "get austria name" do
        value = @austria.name
        be_valid value.to_s.eql?("Austria")
    end

    it "get austria background information" do
        value = @austria.background
        be_valid !value.nil?
    end

    it "get austria population information" do
        value = @austria.population_total
        be_valid !value.nil?
    end

    it "get austria legalsystem property (not wrapped)" do
        value = @austria.get_factbook_property("legalsystem")
        be_valid !value.nil?
    end

    it "get austria latitude" do
        value = @austria.latitude
        be_valid value.to_s.eql?("47.3333333333333")
    end

    it "get austria longitude" do
        value = @austria.longitude
        be_valid value.to_s.eql?("13.3333333333333")
    end

    it "get austria landboundary" do
        value = @austria.landboundary
        be_valid value.count == 7
    end

    it "get austria terrain" do
        value = @austria.terrain
        be_valid !value.nil?
    end

    it "get austria total airports" do
        value = @austria.airports_total
        be_valid value.to_s.eql?("55")
    end

    it "get austria heliports" do
        value = @austria.heliports
        be_valid value.to_s.eql?("1")
    end

    it "get austria climate" do
        value = @austria.climate
        be_valid !value.nil?
    end

    it "get austria location description" do
        value = @austria.location
        be_valid !value.nil?
    end
end
