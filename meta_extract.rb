require 'nokogiri'
require 'open-uri'
require 'awesome_print'

require 'microdata'

module Extractor
  class Extractor::HTMLParser

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

    def get_microdata_json(doc)
      microdata = Microdata::Document.new(doc.to_s)
      items = microdata.extract_items
      extract_microdata(items)
    end

    def extractLink(url)
      doc = Nokogiri::HTML(open(url))

      ap get_microdata_json(doc)

      doc.css('link').each do |node|
        if !node['type'].nil?
          puts node['type'] + " => " + node['href']
          if node['type'].downcase.eql?("application/rdf+xml")
            rdf = Nokogiri::XML(open(node['href']))
            ap "-------------"
            ap "Name:         #{rdf.xpath("/rdf:RDF/foaf:Person/foaf:name", rdf.namespaces).text}"
            ap "Homepage:     #{rdf.xpath("/rdf:RDF/foaf:Person/foaf:homepage/@rdf:resource", rdf.namespaces).text}"
            pubs = rdf.xpath("/rdf:RDF/foaf:Person/foaf:publications/@rdf:resource", rdf.namespaces)
            if pubs
              pubs.each do |pub|
                publication = rdf.xpath("//rdf:RDF/*[@rdf:ID='#{pub.text.gsub('#', '')}']")
                if publication
                  ap "Publications: #{publication.xpath("./bibtex:hasTitle").text}"
                end
              end
            end
            ap "-------------"
          end
        end
      end
    end

    def extractMeta(url)
      doc = Nokogiri::HTML(open(url))

      doc.css('meta').each do |node|
        if !node['name'].nil?
          puts node['name'] + " => " + node['content']
        end
        if !node['property'].nil?
          puts node['property'] + " => " + node['content']
        end
      end
    end
  end

end

url = "https://www.alex-oberhauser.com"

html = Extractor::HTMLParser.new
html.extractLink url
#puts "-------------"
#html.extractMeta url
