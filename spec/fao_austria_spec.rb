require 'spec_helper'

describe SemanticCrawler::Fao do

    before(:all) do
        @obj = SemanticCrawler::Fao::Country.new("Austria")
    end

    it "init empty country object" do
        @obj = SemanticCrawler::Fao::Country.new(nil)
        @obj.country_name.should.eql?(nil)
        @obj.url.should eq(nil)
    end

    it "check austria object" do
        @obj.country_name.should.eql?("Austria")
        @obj.url.should eq("http://www.fao.org/countryprofiles/geoinfo/geopolitical/data/Austria")
    end

    it "get austria RDF/XML dump" do
        be_valid !@obj.xml_document.empty?
    end

    it "get austria type" do
        @obj.type_url.should eq("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/self_governing")
    end

    it "get austria location (max/min lat, max/min long)" do
        @obj.max_latitude.should eq("49.02")
        @obj.max_longitude.should eq("17.16")
        @obj.min_latitude.should eq("46.38")
        @obj.min_longitude.should eq("9.54")
    end

    it "get land area" do
        @obj.land_area_notes.should eq("Official data reported on FAO Questionnaires from countries")
        @obj.land_area_total.should eq("8243.5")
        @obj.land_area_unit.should eq("1000 Ha")
        @obj.land_area_year.should eq("2009")
    end

    it "get currency in en/es/fr" do
        @obj.name_currency("en").should eq("euro")
        @obj.name_currency("es").should eq("euro")
        @obj.name_currency("fr").should eq("euro")
    end

    it "get official name in en/es/fr" do
        @obj.official_name("en").should eq("the Republic of Austria")
        @obj.official_name("es").should eq("la Rep&#xFA;blica de Austria")
        @obj.official_name("fr").should eq("la R&#xE9;publique d'Autriche")
    end

    it "get is in group (URL)" do
        group = @obj.is_in_group_url
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/EU").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Europe").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/FAO").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/World").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/western_Europe").should be_true
    end

    it "get is in group (Name)" do
        group = @obj.is_in_group_name
        group.include?("EU").should be_true
        group.include?("Europe").should be_true
        group.include?("FAO").should be_true
        group.include?("World").should be_true
        group.include?("western_Europe").should be_true
    end

    it "get has boarder with (URL)" do
        group = @obj.has_boarder_with_url
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Czech_Republic_the").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Germany").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Hungary").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Italy").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Liechtenstein").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Slovakia").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Slovenia").should be_true
        group.include?("http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/Switzerland").should be_true
    end

    it "get has boarder with (Name)" do
        group = @obj.has_boarder_with_name
        group.include?("Czech_Republic_the").should be_true
        group.include?("Germany").should be_true
        group.include?("Hungary").should be_true
        group.include?("Italy").should be_true
        group.include?("Liechtenstein").should be_true
        group.include?("Slovakia").should be_true
        group.include?("Slovenia").should be_true
        group.include?("Switzerland").should be_true
    end

    it "get same as links" do
        links = @obj.same_as
        links.include?("http://aims.fao.org/aos/agrovoc/c_718").should be_true
        links.include?("http://dbpedia.org/resource/Austria").should be_true
    end

    it "get population information (notes/total/unit/year)" do
        @obj.population_notes.should eq("2010 Revision from the UN Population Division")
        @obj.population_total.should eq("8394.0")
        @obj.population_unit.should eq("1000")
        @obj.population_year.should eq("2010")
    end

    it "get valid since/until" do
        @obj.valid_since.should eq("1985")
        @obj.valid_until.should eq("9999")
    end

    it "get dbpedia id" do
        @obj.code_dbpedia_id.should eq("Austria")
    end

end
