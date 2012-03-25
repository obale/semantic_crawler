$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "semantic_crawler/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "semantic-crawler"
  s.version     = SemanticCrawler::VERSION
  s.authors     = ["Alex Oberhauser"]
  s.email       = ["alex.oberhauser@sigimera.org"]
  s.homepage    = "https://github.com/obale/semantic_crawler"
  s.summary     = "SemanticCrawler is a ruby library that encapsulates data gathering from different sources."
  s.description = "SemanticCrawler is a ruby library that encapsulates data gathering from different sources."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  s.add_dependency "httparty"
  s.add_dependency "json"
  #s.add_dependency "google-api-client" # Freebase API access
  s.add_dependency "nokogiri"           # XML Parsing

  s.add_development_dependency "sqlite3"
end
