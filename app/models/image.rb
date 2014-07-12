class Image < ActiveRecord::Base
  mount_uploader :file, ImageUploader

  validates_presence_of :file
end
