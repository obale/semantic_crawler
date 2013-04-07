require 'spec_helper'

describe SemanticCrawler::Websites do
  it "test microdata extraction" do
    m = SemanticCrawler::Websites::MicroData.new("https://www.alex-oberhauser.com").to_s
    m['http://schema.org/ItemList'].first['itemListElement'].size.should > 0
    m['http://schema.org/Organization'].size.should > 2
  end
end
