# encoding: UTF-8

module SemanticCrawler
    module LinkedGeoData
        # Specifies relevant nodes that are near a location. Classified by
        # GPS coordinates and radius
        class RelevantNodes
            # Namespace hash
            @@NAMESPACES = {
                "rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            }

            # The input latitude value
            attr_reader :latitude

            # The input longitude value
            attr_reader :longitude

            # The input radius value in meters
            attr_reader :radius

            # The linkedgeodata.org link to the relevant nodes
            attr_reader :url

            def initialize(new_latitude, new_longitude, new_radius, type = nil)
                if !new_latitude.nil? && !new_longitude.nil? && !new_radius.nil?
                    @latitude = new_latitude
                    @longitude = new_longitude
                    @radius = new_radius
                    @url = "http://linkedgeodata.org/triplify/near/#{@latitude},#{@longitude}/#{@radius}"
                    if !type.nil?
                        @url += "/class/#{type}"
                    end
                    begin
                        fetch_rdf
                    rescue => e
                        $log.error("Not able to get linked geo data information, through exception: #{e}")
                    end
                end
            end

            # Returns an array of SemanticCrawler::LinkedGeoData::RelevantNode
            # objects
            def relevant_nodes
                nodeset = query_root_node("rdf:Description", @@NAMESPACES)
                @items = []
                if !nodeset.nil?
                    nodeset.each do |item|
                        node_obj = SemanticCrawler::LinkedGeoData::RelevantNode.new(item)
                        @items << node_obj
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

            # Outputs the document as XML
            def xml_document
                @root_node.to_s
            end

            private
            # Retrieves the RDF file
            def fetch_rdf
                @doc = Nokogiri::XML(open(@url, "Accept" => "application/rdf+xml"))
                @root_node = @doc.xpath("/rdf:RDF", @@NAMESPACES)
            end
        end
    end
end
