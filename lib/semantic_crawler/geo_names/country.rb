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

            # Returns an ISO 3166-1 alpha-2 country code
            def get_country_code
                Geonames::WebService.country_code @latitude, @longitude
            end

            # Returns the name of the country
            def get_country_name
                subdivision = Geonames::WebService.country_subdivision @latitude, @longitude
                subdivision.country_name
            end

            # Returns a Wikipedia object that contains a link to the article,
            # summary and many more fields.
            def get_wikipedia_articles
                Geonames::WebService.find_nearby_wikipedia :lat => @latitude, :long => @longitude
            end

            # @return [SemanticCrawler::Factbook::Country] A Factbook country object
            def get_factbook_country
                SemanticCrawler::Factbook::Country.new get_country_name
            end

            # @return [SemanticCrawler::Fao::Country] A Food and Agriculture country object
            def get_fao_country
                SemanticCrawler::Fao::Country.new get_country_name
            end

        end
    end
end
