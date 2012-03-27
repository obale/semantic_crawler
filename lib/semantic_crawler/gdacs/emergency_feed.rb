# encoding: UTF-8

module SemanticCrawler
    module Gdacs
        # The emergency GDACS.org RSS feed contains the very, very basic
        # information about emergencies.
        class EmergencyFeed

            # The gdacs.org RSS feed URL. (default:
            # http://new.gdacs.org/xml/rss.xml)
            attr_reader :url

            # Initializes the gdacs.org feed URL. If not specified the default
            # URL (http://new.gdacs.org/xml/rss.xml) is used. Normally the
            # feed URL should not be changed.
            def initialize(new_url = "http://new.gdacs.org/xml/vo.xml")
                @url = new_url
                @root_node = nil
                begin
                    fetch_feed
                rescue => e
                    puts "Not able to get country information, through exception: " + e.message
                end
            end

            # Get rss/channel/title
            def title
                query_root_node("title/text()")
            end

            # Get rss/channel/description
            def description
                query_root_node("description/text()")
            end

            # Get rss/channel/item*
            def items
               nodeset = query_root_node("item")
               @items = []
               nodeset.each do |item|
                   item_obj = SemanticCrawler::Gdacs::EmergencyFeedItem.new(item)
                   @items << item_obj
               end
               @items
            end

            # Query the root_node
            def query_root_node(xpath_query, namespaces = {})
                if !@root_node.nil?
                    @root_node.xpath(xpath_query, namespaces)
                end
            end

            # Returns the whole RSS feed as XML
            def xml_document
                @root_node.to_s
            end

            private
                # Retrieves the RSS feed
                def fetch_feed
                    @doc = Nokogiri::XML(open(@url))
                    @root_node = @doc.xpath("/rss/channel")
                end
        end
    end
end
