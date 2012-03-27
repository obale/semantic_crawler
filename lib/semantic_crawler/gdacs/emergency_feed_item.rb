# encoding: UTF-8

module SemanticCrawler
    module Gdacs
        # One emergency crisis entity.
        class EmergencyFeedItem
            # XML namespaces used for the parsing process
            @@NAMESPACES = {
                "gdacs" => "http://www.gdacs.org",
                "glide" => "http://glidenumber.net"
            }

            def initialize(new_root_node)
                @root_node = new_root_node
            end

            # Returns the crisis title
            def title
                query_root_node("title/text()")
            end

            # Returns the crisis gdacs link
            def link
                query_root_node("link/text()")
            end

            # Returns the publication date
            def pubDate
                query_root_node("pubDate/text()")
            end

            # Returns a human readable event type
            def eventType
                query_root_node("gdacs:eventType/text()", @@NAMESPACES)
            end

            # Returns the last updated datetime
            def lastUpdate
                query_root_node("gdacs:lastUpdate/text()", @@NAMESPACES)
            end
            # Returns the glide number
            def glide
                query_root_node("glide:number/text()", @@NAMESPACES)
            end

            # Query the root_node
            def query_root_node(xpath_query, namespaces = {})
                if !@root_node.nil?
                    @root_node.xpath(xpath_query, namespaces)
                end
            end

        end
    end
end
