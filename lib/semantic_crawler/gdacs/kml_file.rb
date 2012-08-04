# encoding: UTF-8

module SemanticCrawler
	module Gdacs
		# The GDACS.org KML file contains geo information about the latest
		# crises.
		class KmlFile

			#  XML namespaces used for the parsing process
			@@NAMESPACES = {
				"k" => "http://www.opengis.net/kml/2.2"
			}

			# The gdacs.org KML file URL. (default:
			# http://www.gdacs.org/xml/gdacs.kml)
			attr_reader :url
			
			# Initializes the gdacs.org KML file URL. If not specified the default
			# URL (http://www..gdacs.org/xml/gdacs.kml) is used. Normally the
			# file URL should not be changed.
			def initialize(new_url = "http://www.gdacs.org/xml/gdacs.kml")
				@url = new_url
				@root_node = nil
				begin
					fetch_file
				rescue => e
					$log.error("Not able to get country information, through exception: #{e}")
				end
			end

			def name
				query_root_node("k:name/text()", @@NAMESPACES)
			end

			def placemark(crisis_id)
				query_root_node("//k:Placemark[@id='#{crisis_id}']", @@NAMESPACES)
			end

			# Query the root node
			def query_root_node(xpath_query, namespace = {})
				if !@root_node.nil?
					@root_node.xpath(xpath_query, namespace)
				end
			end

            private
            # Retrieves the RSS feed
            def fetch_file
                @doc = Nokogiri::XML(open(@url))
                @root_node = @doc.xpath("/k:kml/k:Document", @@NAMESPACES)
            end 

		end
	end
end
