require "spec_helper"

describe RssImport do
  let(:rss_import) { RssImport.new('http://www.oneadam.net/index.html?feed=rss2') }
  it 'should load from a file name' do
    rss_import.should be_feed_loaded
  end

  describe '#import' do
    it 'should do an import' do
      rss_import.import(User.create(email: 'test@test.com', password: 'password'))
      puts "Count: #{Post.all.count}"
    end
  end
end