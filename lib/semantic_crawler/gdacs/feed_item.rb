# encoding: UTF-8

module SemanticCrawler
    module Gdacs
        # One crisis entity with related resources. Could be one of the
        # following crisis types:
        #
        # * Floods 
        # * Earthquakes
        # * Tropical Cyclones
        # * Volcanoes
        class FeedItem
            # XML namespaces used for the parsing process
            @@NAMESPACES = {
                "gdacs" => "http://www.gdacs.org",
                "asgard" => "http://asgard.jrc.it",
                "geo" => "http://www.w3.org/2003/01/geo/wgs84_pos#",
                "dc" => "http://purl.org/dc/elements/1.1/"
            }

            def initialize(new_root_node)
                @root_node = new_root_node
            end

            # Returns the crisis title
            def title
                query_root_node("title/text()")
            end

            # Returns the crisis description
            def description
                query_root_node("description/text()")
            end

            # Returns the enclosure URL
            def enclosure_url
                query_root_node("enclosure/@url")
            end

            # Returns the enclosure type, e.g. image/png
            def enclosure_type
                query_root_node("enclosure/@type")
            end

            # Returns the enclosure length, e.g. 1
            def enclosure_length
                query_root_node("enclosure/@length")
            end

            # Returns the crisis gdacs link
            def link
                query_root_node("link/text()")
            end

            # Returns the publication date
            def pubDate
                query_root_node("pubDate/text()")
            end

            # Returns the crisis start date
            def fromdate
                query_root_node("gdacs:fromdate/text()", @@NAMESPACES)
            end

            # Returns the crisis end date
            def todate
                query_root_node("gdacs:todate/text()", @@NAMESPACES)
            end

            # Returns the crisis subject abbreviation
            def subject
                query_root_node("dc:subject/text()", @@NAMESPACES)
            end

            # Returns an unique crisis identifier (could be non permanent)
            def guid
                query_root_node("guid/text()")
            end

            # Returns the latitude GPS coordinate where the crisis has occurred
            def latitude
                query_root_node("geo:Point/geo:lat/text()", @@NAMESPACES)
            end

            # Returns the longitude GPS coordinate where the crisis has occurred
            def longitude
                query_root_node("geo:Point/geo:long/text()", @@NAMESPACES)
            end

            # Returns the version
            def version
                query_root_node("gdacs:version/text()", @@NAMESPACES)
            end

            # Returns the event type abbreviation, e.g. VO (for volcanic
            # eruption, EQ (for earthquake), FL (for flood), TC (for tropical
            # cyclone)
            def eventtype
                query_root_node("gdacs:eventtype/text()", @@NAMESPACES)
            end

            # Returns the alert level, could be GREEN, ORANGE or RED
            def alertlevel
                query_root_node("gdacs:alertlevel/text()", @@NAMESPACES)
            end

            # Returns the event name if available
            def eventname
                query_root_node("gdacs:eventname/text()", @@NAMESPACES)
            end

            # Returns the event id
            def eventid
                query_root_node("gdacs:eventid/text()", @@NAMESPACES)
            end

            # Returns the episode id
            def episodeid
                query_root_node("gdacs:episodeid/text()", @@NAMESPACES)
            end

            # Returns the severity as human readable string
            def severity
                query_root_node("gdacs:severity/text()", @@NAMESPACES)
            end

            # Returns the population as human readable string
            def population
                query_root_node("gdacs:population/text()", @@NAMESPACES)
            end

            # Returns the vulnerability as human readable string
            def vulnerability
                query_root_node("gdacs:vulnerability/text()", @@NAMESPACES)
            end

            # Returns the country iso3 code if available
            def iso3
                query_root_node("gdacs:iso3/text()", @@NAMESPACES)
            end

            # Returns the country name(s)
            def country
                query_root_node("gdacs:country/text()", @@NAMESPACES)
            end

            # Returns ...
            def glide
                query_root_node("gdacs:glide/text()", @@NAMESPACES)
            end

            # Returns an array of SemanticCrawler::Gdacs::Resource objects
            def resources
               nodeset = query_root_node("gdacs:resources/gdacs:resource", @@NAMESPACES)
               @items = []
               if !nodeset.nil?
                   nodeset.each do |item|
                       item_obj = SemanticCrawler::Gdacs::Resource.new(item)
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

        end
    end
end
