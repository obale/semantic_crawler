require 'spec_helper'

describe SemanticCrawler::Fao do

    it "init Country object" do
        obj = SemanticCrawler::Fao::Country.new("Austria")
        obj.country_name.should.eql?("Austria")
    end

    pending "Implement the 'Fao' module"

end
