require "httparty"

module SemanticCrawler
end

# Freebase.com - module: Freebase
require "semantic_crawler/freebase/crawler"
require "semantic_crawler/freebase/entity"
require "semantic_crawler/freebase/country"

# CIA Factbook RDF Dump - module: Factbook
require "semantic_crawler/factbook"
require "semantic_crawler/factbook/country"

# LinkedGeoData (http://linkedgeodata.org) - module: LinkedGeoData
require "semantic_crawler/linked_geo_data/relevant_node"

# GDACS (http://gdacs.org) - module: Gdacs
require "semantic_crawler/gdacs/feed.rb"
require "semantic_crawler/gdacs/feed_item.rb"
require "semantic_crawler/gdacs/resource.rb"
