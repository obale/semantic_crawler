# encoding: UTF-8

module SemanticCrawler
    module Freebase
        # Freebase Country entity. Currently it is very abstract and
        # could be each entry on Freebase.
        class Country
            include HTTParty
            # The URL prefix of an english Freebase RDF entity.
            @@URI_PREFIX = "http://rdf.freebase.com/rdf/en."

            # Namespace hash
            @@NAMESPACES = {
                "rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
                "fb" => "http://rdf.freebase.com/ns/",
                "owl" => "http://www.w3.org/2002/07/owl#"
            }

            # @attribute [r]
            # The read only country name
            attr_reader :country_name

            # Creates a new Freebase object (JSON)
            def initialize(new_country_name)
                @country_name = new_country_name
                if !@country_name.nil?
                    @normalized_country = @country_name.gsub(" ", "_").gsub("USA", "United_States_of_America").downcase
                    @url = @@URI_PREFIX + @normalized_country
                    @subject = "http://rdf.freebase.com/ns/en.#{@normalized_country}"
                    @root_node = nil
                    begin
                        fetch_rdf
                    rescue => e
                        $log.error("Not able to get country information, through exception: #{e}")
                    end
                end
            end

            # Extract the fb:common.topic.topical_webpage property
            # @return [String] Website as String
            def website
                query_root_node("fb:common.topic.topical_webpage/text()", @@NAMESPACES).to_s
            end

            # Extract the fb:type.object.name property
            # @param [String] The language in ISO 3166-1 alpha-2 format
            # @return [String] The country name
            def object_name(lang = "en")
                query_root_node("fb:type.object.name[@xml:lang='#{lang}']/text()", @@NAMESPACES).to_s
            end

            # Extract the fb:location.location.contains properties
            # @return [Array<String>]
            def contains
                return_list = []
                list = query_root_node("fb:location.location.contains/@rdf:resource", @@NAMESPACES)
                if !list.nil?
                    list.each do |entry|
                        return_list << entry.to_s
                    end
                end
                return_list
            end

            # Extract fb:location.country.administrative_divisions properties
            # @return [Array<String>]
            def administrative_divisions
                return_list = []
                list = query_root_node("fb:location.country.administrative_divisions/@rdf:resource", @@NAMESPACES)
                if !list.nil?
                    list.each do |entry|
                        return_list << entry.to_s
                    end
                end
                return_list
            end

            # Extract fb:government.governmental_jurisdiction.agencies
            # @return [Array<String>] Returns the governmental jurisdiction agencies as URLs
            def agencies
                return_list = []
                list = query_root_node("fb:government.governmental_jurisdiction.agencies/@rdf:resource", @@NAMESPACES)
                if !list.nil?
                    list.each do |entry|
                        return_list << entry.to_s
                    end
                end
                return_list
            end

            # Extract the owl:sameAs links
            # @return [Array<String>] A list of same concept URLs, e.g. to dbpedia or nytimes
            def same_as
                return_list = []
                list = query_root_node("owl:sameAs/@rdf:resource", @@NAMESPACES)
                if !list.nil?
                    list.each do |entry|
                        return_list << entry.to_s
                    end
                end
                return_list
            end

            # Executes a xpath query with optional a hash with namespaces
            # @return [String]
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

            private
            # Retrieves the RDF file
            def fetch_rdf
                @doc = Nokogiri::XML(open(@url))
                @root_node = @doc.xpath("//*[@rdf:about='#{@subject}']", @@NAMESPACES)
            end

        end
    end
end
