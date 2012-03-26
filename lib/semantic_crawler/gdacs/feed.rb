# encoding: UTF-8

module SemanticCrawler
    module Gdacs

        # The gdacs.org RSS feed URL. (default:
        # http://new.gdacs.org/xml/rss.xml)
        attr_reader :feed_url

        # The GDACS.org RSS feed contains the latest crisis information about
        # the following crisis types:
        #
        # * Floods
        # * Earthquakes
        # * Tropical Cyclones
        # * Volcanoes
        class Feed
            # [TODO] Implement this class.
            def initialize(new_feed_url = "http://new.gdacs.org/xml/rss.xml")
                @feed_url = new_feed_url
            end
        end
    end
end
