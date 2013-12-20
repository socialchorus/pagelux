require 'minitest/autorun'
require_relative './fixtures/query'
require File.expand_path('../../lib/pagelux/query', __FILE__)

class TestPagelux < MiniTest::Unit::TestCase

  def setup
    @pagelux = Pagelux::Query.new(1)
  end

  def test_defaults
    assert_equal 100,  @pagelux.limit
    assert_equal 1,  @pagelux.page
  end

  def test_perform_first_page
    @pagelux.limit = 5
    query = @pagelux.perform(sample_query)
    assert_equal 5, query.length
    assert_equal ('a'..'e').to_a, query
  end
    
  def test_perform_middle_page
    @pagelux.limit = 5
    @pagelux.page += 1
    query = @pagelux.perform(sample_query)
    assert_equal 5, query.length
    assert_equal ('f'..'j').to_a, query
  end
    
  def test_perform_last_page
    @pagelux.limit = 5
    @pagelux.page += 2
    query = @pagelux.perform(sample_query)
    assert_equal 3, query.length
    assert_equal ('k'..'m').to_a, query
  end

  # query size is 13
  def sample_query
    @sample_query ||= Query.new(('a'..'m').to_a)
  end
end