require 'spec_helper'

describe SemanticCrawler::Gdacs do
    before(:all) do
        @feed = SemanticCrawler::Gdacs::Feed.new
    end

    it "init gdacs feed" do
        be_valid !@feed.url.nil?
    end

    it "get channel title" do
        be_valid !@feed.title.nil?
    end

    it "get channel description" do
        be_valid !@feed.description.nil?
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

    it "get channel item(s)" do
        items = @feed.items
        be_valid !items.nil?
        items.each do |item|
            be_valid !item.title.nil?
            be_valid !item.description.nil?
            be_valid !item.link.nil?
            be_valid !item.pubDate.nil?
            be_valid !item.fromdate.nil?
            be_valid !item.todate.nil?
            be_valid !item.subject.nil?
            be_valid !item.guid.nil?
            be_valid !item.latitude.nil?
            be_valid !item.longitude.nil?
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
            resources = item.resources
            resources.each do |resource|
                be_valid !resource.title.nil?
                be_valid !resource.url.nil?
                be_valid !resource.type.nil?
            end
        end
    end

end
