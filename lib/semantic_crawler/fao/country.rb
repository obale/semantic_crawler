module SemanticCrawler
    module Fao
        # Represents Food and Agriculture information about one country.
        class Country
            attr_reader :country_name

            def initialize(new_country_name)
                @country_name = new_country_name
            end
        end
    end
end
