# encoding: UTF-8

module SemanticCrawler
    module Gdacs
        # A resource is always related to one FeedItem and could have
        # different types. For example xml, map and a lot more.
        class Resource
            # XML namespaces used for the parsing process
            @@NAMESPACES = {
                "gdacs" => "http://www.gdacs.org"
            }

            # Initializes a resource that is related to a crisis element.
            def initialize(new_root_node)
                @root_node = new_root_node
            end

            # Returns the resource URL
            def url
                query_root_node("@url", @@NAMESPACES).to_s.gsub("[gdacs]", "http://www.gdacs.org")
            end

            # Returns the gdacs:title
            def title
                query_root_node("gdacs:title/text()", @@NAMESPACES)
            end

            # Returns the type (attribute in gdacs:resource)
            def type
                query_root_node("@type")
            end

            # Returns the source organization abbreviation ('source' attribute in gdacs:resource)
            def source
                query_root_node("@source")
            end

            # [OPTIONAL] Returns the gdacs:description
            def description
                query_root_node("gdacs:description/text()", @@NAMESPACES)
            end

            # [OPTIONAL] Returns the gdacs:acknowledgements
            def acknowledgements
                query_root_node("gdacs:acknowledgements/text()", @@NAMESPACES)
            end

            # [OPTIONAL] Returns the gdacs:accesslevel
            def accesslevel
                query_root_node("gdacs:accesslevel/text()", @@NAMESPACES)
            end

            # [OPTIONAL] Returns the gdacs:xslt. Only for XML resources!
            def xslt
                query_root_node("gdacs:xslt/text()", @@NAMESPACES)
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
