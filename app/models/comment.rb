class Comment < ActiveRecord::Base
  attr_accessible :body, :author
  validates_presence_of :body

  belongs_to :post
  belongs_to :author, :class_name => 'User'
end
