require 'forwardable'

require "pagelux/query"
require "pagelux/query_paginator"
require "pagelux/version"

module Pagelux
  def self.paginate(query, params)
    QueryPaginator.new(query).paginate(params)
  end
end
