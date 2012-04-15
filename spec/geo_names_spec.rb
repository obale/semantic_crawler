require 'spec_helper'

describe SemanticCrawler::GeoNames do

    before(:all) do
        # Congress und Messe Innsbruck
        @innsbruck = SemanticCrawler::GeoNames::Country.new(47.271338, 11.395333)
    end

    it "get country code" do
        @innsbruck.get_country_code.should eq("AT")
    end

    it "get wikipedia articles" do
        articles = @innsbruck.get_wikipedia_articles
        articles.each do |article|
            article.wikipedia_url.to_s.start_with?("http").should be_true
        end
    end

    it "get country name" do
        @innsbruck.get_country_name.should eq("Austria")
    end

    it "get factbook country" do
        factbook = @innsbruck.get_factbook_country
        factbook.background.to_s.size.should > 0
        factbook.country_name.to_s.should eq("Austria")
    end

    it "get fao country" do
        fao = @innsbruck.get_fao_country
        fao.country_name.to_s.should eq("Austria")
        fao.population_notes.to_s.should eq("2010 Revision from the UN Population Division")
    end
end
