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
            # @return [String]
            def latitude
                query_root_node("geo:lat/text()", @@NAMESPACES).to_s
            end

            # geo:long
            # @return [String]
            def longitude
                query_root_node("geo:long/text()", @@NAMESPACES).to_s
            end

            # The type as URL
            # @return [String]
            def type
                query_root_node("rdf:type/@rdf:resource", @@NAMESPACES).to_s
            end

            # Comment about the entity
            # @return [String]
            def note
                query_root_node("lgdp:note/text()", @@NAMESPACES).to_s
            end

            # Data Source
            # @return [String]
            def created_by
                query_root_node("lgdp:created_by/text()", @@NAMESPACES).to_s
            end

            # User link
            # @return [String]
            def contributor
                query_root_node("lgdo:contributor/@rdf:resource", @@NAMESPACES).to_s
            end

            # Link to way 
            def member_of_way
                query_root_node("lgdo:memberOfWay/@rdf:resource", @@NAMESPACES)
            end

            # Street name
            # @return [String]
            def has_street
                query_root_node("lgdo:hasStreet/text()", @@NAMESPACES).to_s
            end

            # Postal code
            # @return [String]
            def has_postal_code
                query_root_node("lgdo:hasPostalCode/text()", @@NAMESPACES).to_s
            end

            # House number
            # @return [String]
            def has_house_number
                query_root_node("lgdo:hasHouseNumber/text()", @@NAMESPACES).to_s
            end

            # Country in ISO 3166-1 alpha-2
            # @return [String]
            def has_country
                query_root_node("lgdo:hasCountry/text()", @@NAMESPACES).to_s
            end

            # City name
            # @return [String]
            def has_city
                query_root_node("lgdo:hasCity/text()", @@NAMESPACES).to_s
            end

            # Is this place wheelchair friendly?
            # @return [String]
            def wheelchair
                query_root_node("lgdo:wheelchair/@rdf:resource", @@NAMESPACES).to_s
            end

            # Query the root_node
            def query_root_node(xpath_query, namespaces = {})
                if !@root_node.nil?
                    @root_node.xpath(xpath_query, namespaces)
                end
            end

            # Outputs the document as XML
            # @return [String] The document serialized as XML
            def xml_document
                @root_node.to_s
            end

        end
    end
end
