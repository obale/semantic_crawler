class SemanticCrawler::Freebase::Country < SemanticCrawler::Freebase::Entity
    attr_accessor :input_name
    attr_accessor :json_link

    @@uri_prefix = "http://www.freebase.com/experimental/topic/standard/en/"

    def initialize
        @input_name = nil
        @html_link = nil
        @json_link = nil
    end

    # Get Country Information from freebase.com
    #
    # Example:
    #   >> freebaseCrawler = SemanticCrawler::Freebase::Crawler.new
    #   >> austria = freebaseCrawler.getCountry("Austria")
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
