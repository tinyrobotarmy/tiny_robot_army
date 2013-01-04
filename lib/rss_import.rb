require 'feedzirra'
class RssImport

  def initialize(url)
    @feed = Feedzirra::Feed.fetch_and_parse(url)
  end

  def import(importer)
    @feed.entries.each do |entry|
      post = create_post(entry, importer)
    end
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