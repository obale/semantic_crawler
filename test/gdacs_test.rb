require 'test_helper'
require 'pp'

class GdacsTest < ActiveSupport::TestCase
    test "truth" do
        assert_kind_of Module, SemanticCrawler
    end

    test "init gdacs feed" do
        feed = SemanticCrawler::Gdacs::Feed.new
        assert !feed.url.nil?
    end

    test "get channel title" do
        feed = SemanticCrawler::Gdacs::Feed.new
        assert !feed.title.nil?
    end

    test "get channel description" do
        feed = SemanticCrawler::Gdacs::Feed.new
        assert !feed.description.nil?
    end

    test "get channel pubDate" do
        feed = SemanticCrawler::Gdacs::Feed.new
        assert !feed.pubDate.nil?
    end

    test "get channel webMaster" do
        feed = SemanticCrawler::Gdacs::Feed.new
        assert feed.webMaster.to_s.include?("@")
    end

    test "get channel managingEditor" do
        feed = SemanticCrawler::Gdacs::Feed.new
        assert feed.managingEditor.to_s.include?("@")
    end

    test "get channel atom:link" do
        feed = SemanticCrawler::Gdacs::Feed.new
        assert feed.atom_link.to_s.start_with?("http")
    end

    test "get channel item(s)" do
        feed = SemanticCrawler::Gdacs::Feed.new
        items = feed.items
        assert !items.nil?
        items.each do |item|
            assert !item.title.nil?
            assert !item.description.nil?
            assert !item.link.nil?
            assert !item.pubDate.nil?
            assert !item.fromdate.nil?
            assert !item.todate.nil?
            assert !item.subject.nil?
            assert !item.guid.nil?
            assert !item.latitude.nil?
            assert !item.longitude.nil?
            assert !item.version.nil?
            assert !item.eventtype.nil?
            assert !item.alertlevel.nil?
            assert !item.eventname.nil?
            assert !item.eventid.nil?
            assert !item.episodeid.nil?
            assert !item.severity.nil?
            assert !item.population.nil?
            assert !item.vulnerability.nil?
            assert !item.country.nil?
            assert !item.iso3.nil?
            assert !item.glide.nil?
            resources = item.resources
            resources.each do |resource|
                assert !resource.title.nil?
                assert !resource.url.nil?
                assert !resource.type.nil?
            end
        end
    end

end
