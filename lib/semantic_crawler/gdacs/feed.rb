# encoding: UTF-8

module SemanticCrawler
    module Gdacs
        # The GDACS.org RSS feed contains the latest crisis information about
        # the following crisis types:
        #
        # * Floods
        # * Earthquakes
        # * Tropical Cyclones
        # * Volcanoes
        class Feed

            @@NAMESPACES = {
                "atom" => "http://www.w3.org/2005/Atom"
            }

            # The gdacs.org RSS feed URL. (default:
            # http://new.gdacs.org/xml/rss.xml)
            attr_reader :url

            # Initializes the gdacs.org feed URL. If not specified the default
            # URL (http://new.gdacs.org/xml/rss.xml) is used. Normally the
            # feed URL should not be changed.
            def initialize(new_url = "http://new.gdacs.org/xml/rss.xml")
                @url = new_url
                @root_node = nil
                begin
                    fetch_feed
                rescue => e
                    $log.error("Not able to get country information, through exception: #{e}")
                end
            end

            # Get rss/channel/title
            def title
                query_root_node("title/text()")
            end

            # Get rss/channel/link
            def link
                query_root_node("link/text()")
            end

            # Get rss/channel/description
            def description
                query_root_node("description/text()")
            end

            # Get rss/channel/pubDate
            def pubDate
                query_root_node("pubDate/text()")
            end

            # Get rss/channel/webMaster
            def webMaster
                query_root_node("webMaster/text()")
            end

            # Get rss/channel/managingEditor
            def managingEditor
                query_root_node("managingEditor/text()")
            end

            # Get rss/channel/atom:link
            def atom_link
                query_root_node("atom:link/@href", @@NAMESPACES)
            end

            # Get rss/channel/item*
            def items
               nodeset = query_root_node("item")
               @items = []
               if !nodeset.nil?
                   nodeset.each do |item|
                       item_obj = SemanticCrawler::Gdacs::FeedItem.new(item)
                       @items << item_obj
                   end
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
