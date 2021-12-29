require "spec_helper"

describe RssImport do
  # describe 'a newly created rss_import' do
  #   let(:url) { 'http://www.oneadam.net/index.html?feed=rss2' }
  #   let(:httparty) { class_double(HTTParty) }
  #   let(:response) { instance_double("response") }
  #   let(:feed_jira) { class_double(Feedjira) }

  #   before do
  #     allow(httparty).to receive(:get).and_return(response)
  #     allow(response).to receive(:body).and_return('<xml></xml>')
  #     allow(feed_jira).to receive(:parse).and_return 'parsed feed'
  #   end

  #   it 'should fetch and parse url when initialized' do
  #     expect(feed_jira).to receive(:parse).with('<xml></xml>')
  #     RssImport.new(url)
  #   end
  # end

  # describe '#import' do
  #   pending 'should do an import' do
  #   end
  # end
end
