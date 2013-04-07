# encoding: UTF-8

module SemanticCrawler
  module Websites

    # Extract microdata from a website and output it as JSON
    class MicroData

      attr_accessor :url
      attr_accessor :microdata

      def initialize(url)
        doc = Nokogiri::HTML(open(url))
        microdata = Microdata::Document.new(doc.to_s)
        items = microdata.extract_items
        self.microdata = extract_microdata(items)
      end

      def to_json
        microdata.to_json
      end

      def to_s
        microdata
      end

      private
      def extract_microdata(items)
        hash = Hash.new
        if items.kind_of? Array and items.first and items.first.kind_of? String
          hash = items
        elsif items.kind_of? Array and items.first
          items.each do |item|
            props = item.properties
            properties = Hash.new
            props.each do |key, value|
              hash[item.type.first] ||= Array.new
              values = extract_microdata(value)
              properties.merge!(key.to_s => values)
            end
            hash[item.type.first] << properties
          end
        else
          raise "Not implemented!"
        end
        hash
      end

    end

  end
end
