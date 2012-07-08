require 'spec_helper'

describe SemanticCrawler::Gdacs do
    before(:all) do
        @feed = SemanticCrawler::Gdacs::Feed.new
    end

    it "test wrong url" do
        noFeed = SemanticCrawler::Gdacs::Feed.new(nil)
        be_valid noFeed.nil?
    end

    it "init gdacs feed" do
        be_valid !@feed.url.to_s.empty?
    end

    it "get channel title" do
        be_valid !@feed.title.to_s.empty?
    end

    it "get channel description" do
        be_valid !@feed.description.to_s.empty?
    end

    it "get channel link" do
        be_valid !@feed.link.to_s.empty?
    end

    it "get feed dump" do
        be_valid !@feed.xml_document.empty?
    end

    it "get channel pubDate" do
        be_valid !@feed.pubDate.nil?
    end

    it "get channel webMaster" do
        be_valid @feed.webMaster.to_s.include?("@")
    end

    it "get channel managingEditor" do
        be_valid @feed.managingEditor.to_s.include?("@")
    end

    it "get channel atom:link" do
        be_valid @feed.atom_link.to_s.start_with?("http")
    end

    it "get channel items + resources" do
        items = @feed.items
        be_valid !items.nil?
        items.each do |item|
            be_valid !item.title.to_s.empty?
            be_valid !item.description.nil?
            be_valid !item.link.to_s.empty?
            be_valid !item.pubDate.nil?
            be_valid !item.fromdate.nil?
            be_valid !item.todate.nil?
            be_valid !item.subject.nil?
            be_valid !item.guid.nil?
            be_valid !item.latitude.to_s.empty?
            be_valid !item.longitude.to_s.empty?
            be_valid !item.version.nil?
            be_valid !item.eventtype.nil?
            be_valid !item.alertlevel.nil?
            be_valid !item.eventname.nil?
            be_valid !item.eventid.nil?
            be_valid !item.episodeid.nil?
            be_valid !item.severity.nil?
            be_valid !item.population.nil?
            be_valid !item.vulnerability.nil?
            be_valid !item.country.nil?
            be_valid !item.iso3.nil?
            be_valid !item.glide.nil?
            be_valid !item.enclosure_url.nil?
            be_valid !item.enclosure_type.nil?
            be_valid !item.enclosure_length.nil?
            resources = item.resources
            resources.each do |resource|
                be_valid !resource.title.to_s.empty?
                be_valid !resource.url.to_s.empty?
                be_valid !resource.type.to_s.empty?
                be_valid !resource.description.nil?
                be_valid !resource.accesslevel.nil?
                be_valid !resource.xslt.nil?
                be_valid !resource.source.nil?
                be_valid !resource.acknowledgements.nil?
            end
        end
    end

	xit "test kml file" do
        kmlFile = SemanticCrawler::Gdacs::KmlFile.new
		kmlFile.name.to_s.should_not be_empty
		puts kmlFile.placemark("EQ_117653")
		puts "----"
		puts kmlFile.placemark("EQ_117653_Intensity")
	end

    it "test emergency feed" do
        noFeed = SemanticCrawler::Gdacs::EmergencyFeed.new(nil)
        be_valid noFeed.nil?

        @emergency_feed = SemanticCrawler::Gdacs::EmergencyFeed.new
        be_valid !@emergency_feed.xml_document.empty?
        @emergency_feed.title.to_s.should_not be_empty
        @emergency_feed.description.to_s.should_not be_empty
        items = @emergency_feed.items
        items.each do |item|
            item.link.to_s.should_not be_empty
            item.title.to_s.should_not be_empty
            item.eventType.to_s.should_not be_empty
            item.pubDate.to_s.should_not be_empty
            item.lastUpdate.to_s.should_not be_empty
            item.glide.to_s.should_not be_empty
        end

    end

end
