class Status
  attr_reader :id, :title

  def initialize(id, title)
    @id = id
    @title = title
  end

  def self.all
    [DRAFT, PUBLISHED]
  end

  def self.find(id)
    raise ActiveRecord::RecordNotFound.new unless id <=  all.length
    all[id]
  end

  def self.find_by_id(id)
    return nil unless id <= all.length
    all[id]
  end

  DRAFT = Status.new(0, 'Draft')
  PUBLISHED = Status.new(1, 'Published')

end
