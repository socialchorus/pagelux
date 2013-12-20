require 'spec_helper'

describe Pagelux, 'facade' do
  describe '.paginate(query, params)' do
    it "wraps the QueryPaginator" do
      params = double('params')
      query = double('query')
      paginator = double('paginator')

      Pagelux::QueryPaginator.should_receive(:new).with(query).and_return(paginator)
      paginator.should_receive(:paginate).with(params)
      
      Pagelux.paginate(query, params)
    end
  end
end