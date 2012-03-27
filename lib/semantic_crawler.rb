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

# Freebase.com - module: Freebase
require "semantic_crawler/freebase/crawler"
require "semantic_crawler/freebase/entity"
require "semantic_crawler/freebase/country"

# CIA Factbook RDF Dump - module: Factbook
require "semantic_crawler/factbook"
require "semantic_crawler/factbook/country"

# LinkedGeoData (http://linkedgeodata.org) - module: LinkedGeoData
require "semantic_crawler/linked_geo_data"
require "semantic_crawler/linked_geo_data/relevant_node"

# GDACS (http://gdacs.org) - module: Gdacs
require "semantic_crawler/gdacs"
require "semantic_crawler/gdacs/feed.rb"
require "semantic_crawler/gdacs/feed_item.rb"
require "semantic_crawler/gdacs/resource.rb"
require "semantic_crawler/gdacs/emergency_feed.rb"
require "semantic_crawler/gdacs/emergency_feed_item.rb"
