# encoding: UTF-8

require 'nokogiri'
require 'open-uri'

module SemanticCrawler
    module Factbook
        class Country
            @@URI_PREFIX = "http://www4.wiwiss.fu-berlin.de/factbook/data/"

            @@NAMESPACES = {
                "factbook" => "http://www4.wiwiss.fu-berlin.de/factbook/ns#",
                "rdfs" => "http://www.w3.org/2000/01/rdf-schema#",
                "rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            }

            attr_reader :country_name
            attr_reader :url

            # Get Country Information from the CIA Factbook. see
            # http://www4.wiwiss.fu-berlin.de/factbook/
            #
            # Example:
            #   >> austria = SemanticCrawler::Factbook::Country.new("austria")
            #   >> puts austria.background
            #
            # Argumenst:
            #   new_country_name: (String)
            def initialize(new_country_name)
                @country_name = new_country_name
                @url = @@URI_PREFIX + @country_name.downcase.gsub(" ", "_")
                begin
                    fetch_rdf
                rescue => e
                    puts "Not able to get country information, through exception: "
                    puts e.message
                end
            end

            # Returns the country name (rdfs:label)
            def name
                get_rdfs_property("label", "/rdf:RDF/rdf:Description/factbook:landboundary/factbook:Country")
            end

            # Returns background information about the country
            def background
                get_factbook_property("background")
            end

            # Returns background information about the country
            def population_total
                get_factbook_property("population_total")
            end

            # Returns geographiccoordinates latitude 
            def latitude
                get_factbook_property("geographiccoordinates_latitude")
            end

            # Returns geographiccoordinates longitude
            def longitude
                get_factbook_property("geographiccoordinates_longitude")
            end

            # Returns landboundary
            def landboundary
                if !@doc.nil?
                    @doc.xpath("//factbook:landboundary/rdf:Description/@rdf:about", @@NAMESPACES)
                else
                    @doc = Nokogiri::XML::Document.new
                end
            end

            # Returns terrain description (human readable)
            def terrain
                get_factbook_property("terrain")
            end

            # Returns the total number of airports in the country
            def airports_total
                get_factbook_property("airports_total")
            end

            # Returns the number of helicopter airports
            def heliports
                get_factbook_property("heliports")
            end

            # Returns climate description (human readable)
            def climate
                get_factbook_property("climate")
            end

            # Returns location description (human readable)
            def location
                get_factbook_property("location")
            end


            # Abstract method that allows to fetch factbook properties via
            # xpath
            def get_factbook_property(property_name, prefix = "/" )
                if !@doc.nil?
                    @doc.xpath(prefix + "/factbook:" + property_name + "/text()", @@NAMESPACES)
                else
                    @doc = Nokogiri::XML::Document.new
                end
            end

            # Abstract method that allows to fetch rdfs properties via
            # xpath
            def get_rdfs_property(property_name, prefix = "/")
                if !@doc.nil?
                    @doc.xpath(prefix + "/rdfs:" + property_name + "/text()", @@NAMESPACES)
                else
                    @doc = Nokogiri::XML::Document.new
                end
            end

            private
            def fetch_rdf
                @doc = Nokogiri::XML(open(@url))
            end
        end
    end
end
