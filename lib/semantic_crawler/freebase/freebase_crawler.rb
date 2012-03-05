module SemanticCrawler
    module Freebase
        class FreebaseCrawler
            # Returns a country object that contains all relevant
            # information that could be extracted from freebase.com
            def getCountry(countryName)
                country = SemanticCrawler::Freebase::Country.new
                country.input_name = countryName.downcase!
                country
            end
        end
    end
end
