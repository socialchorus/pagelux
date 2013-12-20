require 'spec_helper'

describe Pagelux::Query do
  let(:paginator) { Pagelux::Query.new(page, limit) }

  describe 'normalizing pagination values' do
    context 'when nothing is passed in' do
      let(:paginator) { Pagelux::Query.new  }

      it 'uses defaults' do
        paginator.page.should == 1
        paginator.limit.should == 100
      end
    end

    context 'when nils are passed in (a real case with params)' do
      let(:page) { nil }
      let(:limit) { nil }

      it 'uses defaults' do
        paginator.page.should == 1
        paginator.limit.should == 100
      end
    end

    context 'when page is less than 1' do
      let(:page) { 0 }
      let(:limit) { 100 }

      it "uses first page" do
        paginator.page.should == 1
      end
    end
  end

  describe 'query pagination' do
    let(:limit) { 5 }
    let(:sample_query) { Query.new(('a'..'m').to_a) }
    let(:results) { paginator.perform(sample_query) }

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