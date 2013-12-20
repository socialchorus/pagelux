require 'spec_helper'

describe Pagelux::QueryPaginator do
  let(:query) { Query.new(('a'..'m').to_a) }
  let(:paginator) { Pagelux::QueryPaginator.new(query) }
  # let(:results) { paginator.paginate(params) }

  describe 'normalizing pagination values' do
    let(:params) { {} }

    context 'when nothing is passed in' do
      it 'uses defaults' do
        paginator.paginate(params)

        paginator.page.should == 1
        paginator.limit.should == 100
      end
    end

    context 'when page is less than 1' do
      let(:params) { 
        {
          page: 0
        }
      }

      it "uses first page" do
        paginator.paginate(params)

        paginator.page.should == 1
      end
    end

    context 'when the page is greater than what is available' do
      let(:params) {
        {
          page: 4,
          limit: 5
        }
      }

      it 'gets the last page' do
        paginator.paginate(params)

        paginator.page.should == 3
      end
    end
  end

  describe 'query pagination' do
    let(:results) { paginator.paginate({page: page, limit: 5}) }

    context 'when on first page' do
      let(:page) { 1 }

      it "will return the right records" do
        results.should == ('a'..'e').to_a
      end
    end

    context 'when on middle page' do
      let(:page) { 2 }
      it "will return the right records for a middle page" do
        results.should == ('f'..'j').to_a
      end
    end

    context 'when on last page' do
      let(:page) { 3 }

      it "will return the right records no the last page" do
        results.should == ('k'..'m').to_a
      end
    end
  end
end