module Pagelux
  class Query
    attr_accessor :page, :limit

    def initialize(page, limit=100)
      @page = page.to_i
      @limit = limit.to_i
    end

    def perform(query)
      query.offset((page-1) * limit).limit(limit)
    end
  end
end