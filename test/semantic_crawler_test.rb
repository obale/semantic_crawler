require 'test_helper'
require 'pp'

class SemanticCrawlerTest < ActiveSupport::TestCase
    test "truth" do
        assert_kind_of Module, SemanticCrawler
    end
end
