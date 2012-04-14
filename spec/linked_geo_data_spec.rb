require 'spec_helper'

describe SemanticCrawler::LinkedGeoData do

    before(:all) do
        @dresden = SemanticCrawler::LinkedGeoData::RelevantNodes.new(51.033333, 13.733333, 1000)
        #@dresden = SemanticCrawler::LinkedGeoData::RelevantNodes.new(51.033333, 13.733333, 1000, "TrafficSignals")
    end

    it "check lat/long/radius of dresden" do
        @dresden.latitude.to_s.should eq("51.033333")
        @dresden.longitude.to_s.should eq("13.733333")
        @dresden.radius.to_s.should eq("1000")
    end

    it "output xml dump " do
        @dresden.xml_document.size.should > 0
    end

    it "check single relevant node entries" do
        nodes = @dresden.relevant_nodes
        nodes.each do |item|
            item.xml_document.size.should > 0
            item.latitude.should be
            item.longitude.should be
            item.type.should be
            item.note.should be
            puts item.note
            item.created_by.should be
            item.contributor.should be

            way = item.member_of_way
            way.each do |way_part|
                way_part.should be
            end

            item.wheelchair.should be
            item.has_street.should be
            item.has_postal_code.should be
            item.has_house_number.should be
            item.has_country.should be
            item.has_city.should be
        end
    end
end
