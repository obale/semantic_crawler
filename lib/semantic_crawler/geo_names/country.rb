module SemanticCrawler
    module GeoNames
        # Represents Food and Agriculture information about one country.
        class Country

            # @attribute [r]
            # The input latitude
            attr_reader :latitude

            # @attribute [r]
            # The input longitude
            attr_reader :longitude

            def initialize(new_latitude, new_longitude)
                @latitude = new_latitude
                @longitude = new_longitude
            end

            def get_country_code
                Geonames::WebService.country_code @latitude, @longitude
            end

            def get_country_name
                subdivision = Geonames::WebService.country_subdivision @latitude, @longitude
                subdivision.country_name
            end

            def get_wikipedia_articles
                Geonames::WebService.find_nearby_wikipedia :lat => @latitude, :long => @longitude
            end

            def get_factbook_country
                SemanticCrawler::Factbook::Country.new get_country_name
            end

            def get_fao_country
                SemanticCrawler::Fao::Country.new get_country_name
            end

        end
    end
end
