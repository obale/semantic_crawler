require 'cgi'
require 'httparty'
require 'json'
require 'pp'

query = [{'id' => '/en/austria', 'name' => nil, 'type' => '/location/country', '*' => [{}] }]
query_envelope = {'query' => query }
service_url = 'http://api.freebase.com/api/service/mqlread'
url = service_url + '?query=' + CGI::escape(query_envelope.to_json)

response = HTTParty.get(url, :format => :json)
puts response
