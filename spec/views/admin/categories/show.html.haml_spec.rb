require 'rails_helper'

describe "admin/categories/show", :type => :view do
  before(:each) do
    @category = assign(
      :category, double(:category, title: "Title 1", slug: "slug-1", description: "description 1")
    )
    render
  end

  it 'should render the title beside a name label' do
    expect(rendered).to match(/<dt>Name<\/dt>\n<dd>Title 1<\/dd>/)
  end

  it 'should render the slug beside a label' do
    expect(rendered).to match(/<dt>Slug<\/dt>\n<dd>slug-1<\/dd>/)
  end

  it 'should render the description beside a label' do
    expect(rendered).to match(/<dt>Description<\/dt>\n<dd>description 1<\/dd>/)
  end

end
