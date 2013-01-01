class Comment < ActiveRecord::Base
  validates_presence_of :body

  belongs_to :post
  belongs_to :author, :class_name => 'User'
end
