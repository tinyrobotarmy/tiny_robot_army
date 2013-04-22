require 'spec_helper'

describe "admin/categories/index" do
  before(:each) do
    assign(:categories, [
      stub_model(Category,
        :title => "Title 1",
        :slug => "slug-1",
        :description => "description 1"
      ),
      stub_model(Category,
        :title => "Title 2",
        :slug => "slug-2",
        :description => "description 2"
      )
    ])
    render
  end

  it 'should render a table for the categories' do
    rendered.should =~ /<table/
  end
  describe 'table headings' do

    it 'should render a heading for Name' do
      rendered.should =~ /<th>Name<\/th>/
    end

    it 'should render a heading for Slug' do
      rendered.should =~ /<th>Slug<\/th>/
    end

    it 'should render a heading for Description' do
      rendered.should =~ /<th>Description<\/th>/
    end

    it 'should render a heading for Count of posts' do
      rendered.should =~ /<th>Posts<\/th>/
    end
  end

  describe 'table rows' do

    it 'should render a row for each category' do
      rendered.should have_selector('tbody tr', count: 2)
    end

    it 'should render the category title' do
      rendered.should =~ /<td>Title 1<\/td>/
    end

    it 'should render category Slug' do
      rendered.should =~ /<td>.*slug-1.*<\/td>/
    end

    it 'should render category Description' do
      rendered.should =~ /<td>description 1<\/td>/
    end

    it 'should render category Count of posts' do
      rendered.should =~ /<td>0<\/td>/
    end
  end

end
