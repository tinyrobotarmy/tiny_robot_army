require "spec_helper"

describe RssImport do
  describe 'a newly created rss_import' do
    let(:url) { 'http://www.oneadam.net/index.html?feed=rss2' }
    before do
      Feedjira::Feed.stub(:fetch_and_parse).and_return 'parsed feed'
    end

    it 'should fetch and parse url when initialized' do
      Feedjira::Feed.should_receive(:fetch_and_parse).with(url)
      RssImport.new(url)
    end
  end

  describe '#import' do
    pending 'should do an import' do
    end
  end
end
