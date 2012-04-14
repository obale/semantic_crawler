# encoding: UTF-8

module SemanticCrawler
    module LinkedGeoData
        # Specifies relevant node that is classified by a type
        # and GPS coordinates.
        class RelevantNode
            # Namespace hash
            @@NAMESPACES = {
                "rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
                "rdfs" => "http://www.w3.org/2000/01/rdf-schema#",
                "lgd" => "http://linkedgeodata.org/triplify/",
                "lgdp" => "http://linkedgeodata.org/property/",
                "lgdo" => "http://linkedgeodata.org/ontology/",
                "geo" => "http://www.w3.org/2003/01/geo/wgs84_pos#"
            }


            # Constructor that takes the root node received from
            # SemanticCrawler::LinkedGeoData::RelevantNodes
            def initialize(new_root_node)
                @root_node = new_root_node
            end

            # geo:lat
            def latitude
                query_root_node("geo:lat/text()", @@NAMESPACES)
            end

            # geo:long
            def longitude
                query_root_node("geo:long/text()", @@NAMESPACES)
            end

            # The type as URL
            def type
                query_root_node("rdf:type/@rdf:resource", @@NAMESPACES)
            end

            # Comment about the entity
            def note
                query_root_node("lgdp:note/text()", @@NAMESPACES)
            end

            # Data Source
            def created_by
                query_root_node("lgdp:created_by/text()", @@NAMESPACES)
            end

            # User link
            def contributor
                query_root_node("lgdo:contributor/@rdf:resource", @@NAMESPACES)
            end

            # Link to way 
            def member_of_way
                query_root_node("lgdo:memberOfWay/@rdf:resource", @@NAMESPACES)
            end

            # Street name
            def has_street
                query_root_node("lgdo:hasStreet/text()", @@NAMESPACES)
            end

            # Postal code
            def has_postal_code
                query_root_node("lgdo:hasPostalCode/text()", @@NAMESPACES)
            end

            # House number
            def has_house_number
                query_root_node("lgdo:hasHouseNumber/text()", @@NAMESPACES)
            end

            # Country in ISO 3166-1 alpha-2
            def has_country
                query_root_node("lgdo:hasCountry/text()", @@NAMESPACES)
            end

            # City name
            def has_city
                query_root_node("lgdo:hasCity/text()", @@NAMESPACES)
            end

            # Is this place wheelchair friendly?
            def wheelchair
                query_root_node("lgdo:wheelchair/@rdf:resource", @@NAMESPACES)
            end

            # Query the root_node
            def query_root_node(xpath_query, namespaces = {})
                if !@root_node.nil?
                    @root_node.xpath(xpath_query, namespaces)
                end
            end

            # Outputs the document as XML
            def xml_document
                @root_node.to_s
            end

        end
    end
end
