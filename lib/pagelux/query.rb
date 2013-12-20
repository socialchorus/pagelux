module Pagelux
  class Query
    attr_accessor :page, :limit

    def initialize(page=nil, limit=nil)
      @limit = (limit || self.class.default_limit).to_i
      @page =  normalize_page(page)
    end

    def self.default_page
      1
    end

    def self.default_limit
      100
    end

    def normalize_page(n)
      n = (n  || self.class.default_page).to_i
      n = self.class.default_page if n < self.class.default_page
      n
    end

    def perform(query)
      query.offset((page-1) * limit).limit(limit)
    end
  end
end