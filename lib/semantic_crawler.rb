require "httparty"

module SemanticCrawler
end

# Freebase.com
require "semantic_crawler/freebase/crawler"
require "semantic_crawler/freebase/entity"
require "semantic_crawler/freebase/country"

# CIA Factbook RDF Dump
require "semantic_crawler/factbook/country"

# LinkedGeoData (http://linkedgeodata.org)
require "semantic_crawler/linked_geo_data/relevant_node"
