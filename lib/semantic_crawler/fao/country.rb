module SemanticCrawler
    module Fao
        # Represents Food and Agriculture information about one country.
        class Country

            # Namespace hash
            @@NAMESPACES = {
                "rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
                "fao" => "http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/",
                "owl" => "http://www.w3.org/2002/07/owl#"
            }

            # @attribute [r]
            # The read only country name
            attr_reader :country_name

            # @attribute [r]
            # The read only URL to the FAO resource
            attr_reader :url

            # Initialize a new Fao country object
            def initialize(new_country_name)
                @country_name = new_country_name
                @url = "http://www.fao.org/countryprofiles/geoinfo/geopolitical/data/#{@country_name}"
                @root_node = nil
                begin
                    fetch_rdf
                rescue => e
                    $log.error("Not able to get country information, through exception: #{e}")
                end
            end

            # The dbpedia identifier (from fao:codeDBPediaID)
            def code_dbpedia_id
                query_root_node("fao:codeDBPediaID/text()", @@NAMESPACES).to_s
            end

            # Links to additional information (from owl:sameAs)
            def same_as
                returnLinks = []
                links = query_root_node("owl:sameAs/@rdf:resource", @@NAMESPACES)
                links.each do |link|
                    returnLinks << link.to_s
                end
                returnLinks
            end

            # The type as URL of this entity (from rdf:type)
            def type_url
                query_root_node("rdf:type/@rdf:resource", @@NAMESPACES).to_s
            end

            # The maximum latitude (from fao:hasMaxLatitude)
            def max_latitude
                query_root_node("fao:hasMaxLatitude/text()", @@NAMESPACES).to_s
            end

            # The maximum longitude (from fao:hasMaxLongitude)
            def max_longitude
                query_root_node("fao:hasMaxLongitude/text()", @@NAMESPACES).to_s
            end

            # The minimum latitude (from fao:hasMinLatitude)
            def min_latitude
                query_root_node("fao:hasMinLatitude/text()", @@NAMESPACES).to_s
            end

            # The minimum longitude (from fao:hasMinLongitude)
            def min_longitude
                query_root_node("fao:hasMinLongitude/text()", @@NAMESPACES).to_s
            end

            # Human readable description about the land area (from fao:landAreaNotes)
            def land_area_notes
                query_root_node("fao:landAreaNotes/text()", @@NAMESPACES).to_s
            end

            # Land area total value (from fao:landAreaTotal)
            def land_area_total
                query_root_node("fao:landAreaTotal/text()", @@NAMESPACES).to_s
            end

            # Land area unit (from fao:landAreaUnit)
            def land_area_unit
                query_root_node("fao:landAreaUnit/text()", @@NAMESPACES).to_s
            end

            # Land area year (from fao:landAreaYear)
            def land_area_year
                query_root_node("fao:landAreaYear/text()", @@NAMESPACES).to_s
            end

            # The currency name.
            # @param [Lang] The language in which the currency name should be returned
            def name_currency(lang)
                query_root_node("fao:nameCurrency[@xml:lang='#{lang}']/text()", @@NAMESPACES).to_s
            end

            # The official country name
            # @param [Lang] The language in which the official name should be returned
            def official_name(lang)
                query_root_node("fao:nameOfficial[@xml:lang='#{lang}']/text()", @@NAMESPACES).to_s
            end

            # Classification of this country as name (from fao:isInGroup)
            def is_in_group_name
                returnGroup = []
                group = query_root_node("fao:isInGroup/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s.split("/")[7]
                end
                returnGroup
            end

            # Classification of this country as dereferenceable URL (from
            # fao:isInGroup)
            def is_in_group_url
                returnGroup = []
                group = query_root_node("fao:isInGroup/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s
                end
                returnGroup
            end

            # Returns all countries that share a boarder with this country (as
            # dereferencable URL - from fao:hasBorderWith)
            def has_boarder_with_url
                returnGroup = []
                group = query_root_node("fao:hasBorderWith/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s
                end
                returnGroup
            end

            # Returns all countries that share a boarder with this country (as
            # name)
            def has_boarder_with_name
                returnGroup = []
                group = query_root_node("fao:hasBorderWith/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s.split("/")[7]
                end
                returnGroup
            end

            # Population notes (from fao:populationNotes)
            def population_notes
                query_root_node("fao:populationNotes/text()", @@NAMESPACES).to_s
            end

            # Population total (from fao:populationTotal)
            def population_total
                query_root_node("fao:populationTotal/text()", @@NAMESPACES).to_s
            end

            # Population unit (from fao:populationUnit)
            def population_unit
                query_root_node("fao:populationUnit/text()", @@NAMESPACES).to_s
            end

            # Population year (from fao:populationYear)
            def population_year
                query_root_node("fao:populationYear/text()", @@NAMESPACES).to_s
            end

            # Entity is valid since (from fao:validSince)
            def valid_since
                query_root_node("fao:validSince/text()", @@NAMESPACES).to_s
            end

            # Entity is valid until (from fao:validUntil)
            def valid_until
                query_root_node("fao:validUntil/text()", @@NAMESPACES).to_s
            end

            # Executes a xpath query with optional a hash with namespaces
            def query_root_node(xpath_query, namespaces = {})
                if !@root_node.nil?
                    @root_node.xpath(xpath_query, namespaces)
                end
            end

            # Outputs the document as XML
            def xml_document
                @root_node.to_s
            end

            private
                # Retrieves the RDF file
                def fetch_rdf
                    @doc = Nokogiri::XML(open(@url))
                    @root_node = @doc.xpath("/rdf:RDF/rdf:Description", @@NAMESPACES)
                end
        end
    end
end
