class Category < ActiveRecord::Base
  attr_accessible :title, :slug, :description
  has_and_belongs_to_many :posts
  validates_presence_of :title
  validates_uniqueness_of :slug, :title
  before_validation :create_slug, on: :create

  private
  def create_slug
    self.slug = title.parameterize unless self.slug.present? || title.nil?
  end
end
