require 'spec_helper'

describe SemanticCrawler::Freebase do

    before(:all) do
        @country = SemanticCrawler::Freebase::Country.new("Austria")
    end

    it "test empty country" do
        emptyCountry = SemanticCrawler::Freebase::Country.new(nil)
        emptyCountry.country_name.should_not be
    end

    it "check austria country name and xml_document" do
        @country.country_name.should eq("Austria")
        @country.xml_document.size.should > 0
    end

    it "check same as links" do
        links = @country.same_as
        links.size.should > 0
        links.each do |link|
            be_valid link.start_with?("http")
        end
    end

    it "check website" do
        @country.website.should eq("http://www.austria.gv.at/")
    end

    it "check object name" do
        @country.object_name.should eq("Austria")
        @country.object_name("en").should eq("Austria")
        @country.object_name("sl").should eq("Avstrija")
        @country.object_name("cs").should eq("Rakousko")
    end

    it "check same as links" do
        links = @country.contains
        links.size.should > 0
        links.each do |link|
            be_valid link.start_with?("http")
        end
    end

    it "check administrative divisions" do
        links = @country.administrative_divisions
        links.size.should > 0
        links.each do |link|
            be_valid link.start_with?("http")
        end
    end

    it "check agencies" do
        links = @country.agencies
        links.size.should > 0
        links.each do |link|
            be_valid link.start_with?("http")
        end
    end

end
