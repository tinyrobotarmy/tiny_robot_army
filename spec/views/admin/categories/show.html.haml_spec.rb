require 'spec_helper'

describe "admin/categories/show" do
  before(:each) do
    @category = assign(
      :category, stub_model(Category,
        :title => "Title 1",
        :slug => "slug-1",
        :description => "description 1"
      ))
    render
  end

  it 'should render the title beside a name label' do
    rendered.should =~ /<dt>Name<\/dt>\n<dd>Title 1<\/dd>/
  end

  it 'should render the slug beside a label' do
    rendered.should =~ /<dt>Slug<\/dt>\n<dd>slug-1<\/dd>/
  end

  it 'should render the description beside a label' do
    rendered.should =~ /<dt>Description<\/dt>\n<dd>description 1<\/dd>/
  end

end
