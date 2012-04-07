require 'spec_helper'

describe SemanticCrawler::Fao do

    before(:all) do
        @obj = SemanticCrawler::Fao::Country.new("Papua New Guinea")
    end

    it "check papua new guinea object" do
        @obj.country_name.should eq("Papua New Guinea")
        @obj.url.should eq("http://www.fao.org/countryprofiles/geoinfo/geopolitical/data/Papua_New_Guinea")
    end

    it "get papua new guinea RDF/XML dump" do
        be_valid !@obj.xml_document.empty?
    end

    it "get papa new guinea type" do
        @obj.type_url.should eq("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/self_governing")
    end

    it "get papa new guinea location (max/min lat, max/min long)" do
        @obj.max_latitude.should eq("-1.13")
        @obj.max_longitude.should eq("159.49")
        @obj.min_latitude.should eq("-11.66")
        @obj.min_longitude.should eq("140.87")
    end

    it "get land area" do
        @obj.land_area_notes.should eq("Manual Estimation")
        @obj.land_area_total.should eq("45286.0")
        @obj.land_area_unit.should eq("1000 Ha")
        @obj.land_area_year.should eq("2009")
    end

    it "get currency in en/es/fr" do
        @obj.name_currency("en").should eq("kina")
        @obj.name_currency("es").should eq("kina")
        @obj.name_currency("fr").should eq("kina")
    end

    it "get official name in en/es/fr" do
        @obj.official_name("en").should eq("Papua New Guinea")
        @obj.official_name("es").should eq("Papua Nueva Guinea")
        @obj.official_name("fr").should eq("la Papouasie-Nouvelle-Guin&#xE9;e")
    end

    it "get is in group (URL)" do
        group = @obj.is_in_group_url
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Oceania").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Melanesia").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/FAO").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/World").should be_true
    end

    it "get is in group (Name)" do
        group = @obj.is_in_group_name
        group.include?("Oceania").should be_true
        group.include?("Melanesia").should be_true
        group.include?("FAO").should be_true
        group.include?("World").should be_true
    end

    it "get has boarder with (URL)" do
        group = @obj.has_boarder_with_url
	group.should.eql?(nil)
    end

    it "get has boarder with (Name)" do
        group = @obj.has_boarder_with_name
	group.should.eql?(nil)
    end

    it "get same as links" do
        links = @obj.same_as
        links.include?("http://aims.fao.org/aos/agrovoc/c_5555").should be_true
        links.include?("http://dbpedia.org/resource/Papua_New_Guinea").should be_true
    end

    it "get population information (notes/total/unit/year)" do
        @obj.population_notes.should eq("2010 Revision from the UN Population Division")
        @obj.population_total.should eq("6858.0")
        @obj.population_unit.should eq("1000")
        @obj.population_year.should eq("2010")
    end

    it "get valid since/until" do
        @obj.valid_since.should eq("1985")
        @obj.valid_until.should eq("9999")
    end

    it "get dbpedia id" do
        @obj.code_dbpedia_id.should eq("Papua_New_Guinea")
    end

end

