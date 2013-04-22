class Post < ActiveRecord::Base
  attr_accessible :subject, :body, :author, :category_ids
  validates_presence_of :subject, :body

  belongs_to :author, :class_name => 'User'
  has_many :comments, order: 'created_at DESC'
  has_and_belongs_to_many :categories

  def body=(value)
    write_attribute(:body, value.nil? ? nil : reject_invalid_input(value))
  end

  def status
    Status.find(status_id) if status_id
  end

  def status=(new_status)
    self.status_id = new_status ? new_status.id : nil
  end

  private
  def reject_invalid_input(string)
    string.gsub(/^<br>$|<script.*>.*<\/script>/, '')
  end

  def set_default_status
    status_id = Status::DRAFT.id unless status_id
  end
end
