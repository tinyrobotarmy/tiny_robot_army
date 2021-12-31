class HtmlImport

  def initialize(filename)
    file = File.new(filename)
    @document = Nokogiri::XML(file)
    file.close
  end

  def import(importer)
    @importer = importer
    @document.css('div.journalentry').each { |entry| parse_entry(entry)}
  end

  def parse_entry(entry)
    created_at = updated_at = DateTime.parse entry.children[2].strip
    
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