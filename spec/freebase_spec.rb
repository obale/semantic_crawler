require 'spec_helper'

describe SemanticCrawler::Freebase do

    it "test empty country" do
        emptyCountry = SemanticCrawler::Freebase::Country.new(nil)
        emptyCountry.get.nil?.should == true
    end

    it "init austria country information" do
        austria = SemanticCrawler::Freebase::Country.new("Austria")
        austria.get.to_s.nil?.should == false
    end

    pending "Implement the 'Freebase' module"

end
