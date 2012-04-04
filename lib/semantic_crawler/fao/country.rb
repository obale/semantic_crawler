module SemanticCrawler
    module Fao
        # Represents Food and Agriculture information about one country.
        class Country

            @@NAMESPACES = {
                "rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
                "fao" => "http://www.fao.org/countryprofiles/geoinfo/geopolitical/resource/",
                "owl" => "http://www.w3.org/2002/07/owl#"
            }

            attr_reader :country_name
            attr_reader :url

            # Initialize a new FAO country object
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

            def code_dbpedia_id
                query_root_node("fao:codeDBPediaID/text()", @@NAMESPACES).to_s
            end

            def same_as
                returnLinks = []
                links = query_root_node("owl:sameAs/@rdf:resource", @@NAMESPACES)
                links.each do |link|
                    returnLinks << link.to_s
                end
                returnLinks
            end

            def type_url
                query_root_node("rdf:type/@rdf:resource", @@NAMESPACES).to_s
            end

            def max_latitude
                query_root_node("fao:hasMaxLatitude/text()", @@NAMESPACES).to_s
            end

            def max_longitude
                query_root_node("fao:hasMaxLongitude/text()", @@NAMESPACES).to_s
            end

            def min_latitude
                query_root_node("fao:hasMinLatitude/text()", @@NAMESPACES).to_s
            end

            def min_longitude
                query_root_node("fao:hasMinLongitude/text()", @@NAMESPACES).to_s
            end

            def land_area_notes
                query_root_node("fao:landAreaNotes/text()", @@NAMESPACES).to_s
            end

            def land_area_total
                query_root_node("fao:landAreaTotal/text()", @@NAMESPACES).to_s
            end

            def land_area_unit
                query_root_node("fao:landAreaUnit/text()", @@NAMESPACES).to_s
            end

            def land_area_year
                query_root_node("fao:landAreaYear/text()", @@NAMESPACES).to_s
            end

            def name_currency(lang)
                query_root_node("fao:nameCurrency[@xml:lang='#{lang}']/text()", @@NAMESPACES).to_s
            end

            def official_name(lang)
                query_root_node("fao:nameOfficial[@xml:lang='#{lang}']/text()", @@NAMESPACES).to_s
            end

            def is_in_group_name
                returnGroup = []
                group = query_root_node("fao:isInGroup/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s.split("/")[7]
                end
                returnGroup
            end

            def is_in_group_url
                returnGroup = []
                group = query_root_node("fao:isInGroup/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s
                end
                returnGroup
            end

            def has_boarder_with_url
                returnGroup = []
                group = query_root_node("fao:hasBorderWith/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s
                end
                returnGroup
            end

            def has_boarder_with_name
                returnGroup = []
                group = query_root_node("fao:hasBorderWith/@rdf:resource", @@NAMESPACES)
                group.each do |entry|
                    returnGroup << entry.to_s.split("/")[7]
                end
                returnGroup
            end

            def population_notes
                query_root_node("fao:populationNotes/text()", @@NAMESPACES).to_s
            end

            def population_total
                query_root_node("fao:populationTotal/text()", @@NAMESPACES).to_s
            end

            def population_unit
                query_root_node("fao:populationUnit/text()", @@NAMESPACES).to_s
            end

            def population_year
                query_root_node("fao:populationYear/text()", @@NAMESPACES).to_s
            end

            def valid_since
                query_root_node("fao:validSince/text()", @@NAMESPACES).to_s
            end

            def valid_until
                query_root_node("fao:validUntil/text()", @@NAMESPACES).to_s
            end

            def query_root_node(xpath_query, namespaces = {})
                if !@root_node.nil?
                    @root_node.xpath(xpath_query, namespaces)
                end
            end

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
