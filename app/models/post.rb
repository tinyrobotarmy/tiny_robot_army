class Post < ActiveRecord::Base
  attr_accessible :subject, :body, :author_id
  validates_presence_of :subject, :body

  belongs_to :author, :class_name => 'User'
  has_many :comments

  def body=(value)
    write_attribute(:body, value.nil? ? nil : reject_invalid_input(value))
  end

  private
  def reject_invalid_input(string)
    string.gsub(/^<br>$|<script.*>.*<\/script>/, '')
  end
end
