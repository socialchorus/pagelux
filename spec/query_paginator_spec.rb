require 'spec_helper'

describe Pagelux::QueryPaginator do
  let(:query) { 
    (1..13).to_a.each do |n|
      Query.create!(n: n)
    end

    Query.all
  }
  let(:paginator) { Pagelux::QueryPaginator.new(query) }

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

    context "when the query count is 0" do
      let(:query) { Query.all }

      let(:params) {
        {
          page: nil,
          limit: 200
        }
      }

      it "uses the first page" do
        paginator.paginate(params)
        paginator.page.should == 1
      end
    end
  end

  describe 'query pagination' do
    let(:results) { paginator.paginate({page: page, limit: 5}).map(&:n) }

    context 'when on first page' do
      let(:page) { 1 }

      it "will return the right records" do
        results.should == (1..5).to_a
      end
    end

    context 'when on middle page' do
      let(:page) { 2 }
      it "will return the right records for a middle page" do
        results.should == (6..10).to_a
      end
    end

    context 'when on last page' do
      let(:page) { 3 }

      it "will return the right records no the last page" do
        results.should == (11..13).to_a
      end
    end
  end

  context 'when query count results in grouped set' do
    let(:page) { 1 }

    let(:query) { 
      (1..13).to_a.each do |n|
        Query.create!(n: n)
      end

      Query.all.select('n').group(:n)
    }

    let(:results) { paginator.paginate({page: page, limit: 5}).map(&:n) }

    it "still return the right number (and does not blow up)" do
      results.size.should == 5
    end
  end
end