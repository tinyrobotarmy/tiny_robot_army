class Image < ActiveRecord::Base
  attr_accessible :fiile
  mount_uploader :file, ImageUploader

  validates_presence_of :file
end
