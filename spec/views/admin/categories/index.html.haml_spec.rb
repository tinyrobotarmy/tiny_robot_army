require 'rails_helper'

describe "admin/categories/index", :type => :view do
  before(:each) do
    assign(:categories, [
      double(:category, title: "Title 1", slug: "slug-1", description: "description 1", posts: []),
      double(:category, title: "Title 2", slug: "slug-2", description: "description 2", posts: [])
    ])
    render
  end

  it 'should render a table for the categories' do
    expect(rendered).to match(/<table/)
  end
  describe 'table headings' do

    it 'should render a heading for Name' do
      expect(rendered).to match(/<th>Name<\/th>/)
    end

    it 'should render a heading for Slug' do
      expect(rendered).to match(/<th>Slug<\/th>/)
    end

    it 'should render a heading for Description' do
      expect(rendered).to match(/<th>Description<\/th>/)
    end

    it 'should render a heading for Count of posts' do
      expect(rendered).to match(/<th>Posts<\/th>/)
    end
  end

  describe 'table rows' do

    it 'should render a row for each category' do
      expect(rendered).to have_selector('tbody tr', count: 2)
    end

    it 'should render the category title' do
      expect(rendered).to match(/<td>Title 1<\/td>/)
    end

    it 'should render category Slug' do
      expect(rendered).to match(/<td>.*slug-1.*<\/td>/)
    end

    it 'should render category Description' do
      expect(rendered).to match(/<td>description 1<\/td>/)
    end

    it 'should render category Count of posts' do
      expect(rendered).to match(/<td>0<\/td>/)
    end
  end

end
