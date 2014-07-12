require 'feedjira'
class RssImport

  def initialize(url)
    @feed = Feedjira::Feed.fetch_and_parse(url)
  end

  def import(importer)
    @feed.entries.each {|entry| create_post(entry, importer) }
  end

  def feed_loaded?
    !!@feed
  end

  private
  def create_post(entry, importer)
    post = Post.create(subject: entry.title, body: entry.content, author: importer)
    post.created_at = entry.published
    post.updated_at = entry.published
    post.save!
    post
  end
end
