module Pagelux
  class QueryPaginator
    extend Forwardable

    attr_reader :base_query

    def initialize(base_query)
      @base_query = base_query
    end

    def paginate(params)
      @pagination_data = PaginationData.new(params[:page], params[:limit], base_query.count)
      limit_query
    end

    def limit_query
      base_query.offset((page-1) * limit).limit(limit)
    end

    def_delegators :@pagination_data, :page, :limit

    class PaginationData
      attr_reader :page, :limit, :total

      def initialize(page=nil, limit=nil, query_total)
        @total = query_total
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
        n = n > last_page ? last_page : n
        n
      end

      def last_page
        (total/limit.to_f).ceil
      end
    end
  end
end