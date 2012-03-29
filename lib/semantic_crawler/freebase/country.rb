# encoding: UTF-8

require 'json'

module SemanticCrawler
    module Freebase
        # Freebase Country entity. Currently it is very abstract and
        # could be each entry on Freebase.
        #
        # [XXX] The current implementation outputs only an unreadable JSON object.
        class Country
            include HTTParty
            # The Freebase object that should be retrieved
            attr_accessor :input_name
            # The URL that points to the JSON object.
            attr_accessor :json_link

            # The URL prefix of an Freebase experimental JSON entity.
            @@uri_prefix = "http://www.freebase.com/experimental/topic/standard/en/"

            # Creates a new Freebase object (JSON)
            def initialize(new_country_name)
                @input_name = new_country_name
                @html_link = nil
                @json_link = nil
            end

            # Get Country Information from freebase.com
            #
            # Example:
            #   >> austria = SemanticCrawler::Freebase::Country.new("Austria")
            #   >> austria.get
            #
            # Argumenst:
            #   options: (Hash)
            #
            #
            def get(options={})
                if !@input_name.nil?
                    @json_link = @@uri_prefix + @input_name
                    JSON(self.class.get(@json_link, options).body)["result"]
                else
                    nil
                end
            end

        end
    end
end
