require 'spec_helper'

describe BlogHelper do
  describe '#blog_title' do
    subject { helper.blog_title category }

    context 'when the category is nil or empty' do
      let(:category) { nil }
      it 'should render All Entries' do
        expect(subject).to eql 'All Entries'
      end
    end

    context 'when there is a category' do
      let(:category) { Category.new(title: 'Super Stuff') }

      it 'should render the title of the category' do
        expect(subject).to eql "#{category.title} Entries"
      end
    end
  end

  describe '#category_link' do
    subject { helper.category_link category, selected_category }
    let(:category) { Category.new(title: 'Super Stuff') }
    let(:selected_category) { nil }

    it 'should render a link with the title of the category as the label' do
      expect(subject).to have_selector('a') do |element|
        expect(element.text).to match /Super Stuff/
      end
    end

    it 'should render a count of entries with that category in the link' do
      category.stub_chain(:posts, :count).and_return 12
      expect(subject).to have_selector('a div.pull-right', text: '12')
    end

    context 'when the selected_category is nil' do
      it 'should not give the link a class of active' do
        expect(subject).to_not have_selector('a.active')
      end
    end
    context 'when the selected_category is not the category provided' do
      let(:selected_category) { Category.new(title: 'something else')}
      it 'should not give the link a class of active' do
        expect(subject).to_not have_selector('a.active')
      end
    end

    context 'when the selected_category is the category provided' do
      let(:selected_category) { category }
      it 'should give the link a class of active' do
        expect(subject).to have_selector('a.active')
      end
    end
  end
end
