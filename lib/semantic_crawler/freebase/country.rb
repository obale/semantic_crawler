module SemanticCrawler
    module Freebase
        class Country
            attr_accessor :input_name
            attr_accessor :html_link
            attr_accessor :rdf_link

            def initialize
                @input_name = nil
                @html_link = nil
                @rdf_link = nil
            end

        end
    end
end
