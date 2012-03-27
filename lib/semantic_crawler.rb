# encoding: UTF-8

require "httparty"

# The top level module contains the different data sources
# as sub-modules. Currently there are the following modules
# available:
#
# * Freebase
# * Factbook
# * LinkedGeoData
# * Gdacs
#
# The existing modules are extended stepwise and additional
# sources are added in the future.
module SemanticCrawler
end

# CIA Factbook RDF Dump - module: Factbook
require "semantic_crawler/factbook"
require "semantic_crawler/factbook/country"

# GDACS.org - module: Gdacs
require "semantic_crawler/gdacs"
require "semantic_crawler/gdacs/feed.rb"
require "semantic_crawler/gdacs/feed_item.rb"
require "semantic_crawler/gdacs/resource.rb"
require "semantic_crawler/gdacs/emergency_feed.rb"
require "semantic_crawler/gdacs/emergency_feed_item.rb"

# DBPedia - module: Dbpedia
require "semantic_crawler/dbpedia"

# GeoNames.org - module: GeoNames
require "semantic_crawler/geo_names"

# Freebase.com - module: Freebase
require "semantic_crawler/freebase/crawler"
require "semantic_crawler/freebase/entity"
require "semantic_crawler/freebase/country"

# LinkedGeoData.org - module: LinkedGeoData
require "semantic_crawler/linked_geo_data"
require "semantic_crawler/linked_geo_data/relevant_node"

