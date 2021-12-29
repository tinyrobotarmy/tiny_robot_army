class Post < ActiveRecord::Base
  validates_presence_of :subject, :body

  belongs_to :author, :class_name => 'User'
  has_many :comments
  has_and_belongs_to_many :categories

  before_validation :set_default_status, on: :create
  after_create :create_slug

  scope :unpinned, -> { where(pinned: false) }
  scope :pinned, -> { where(pinned: true) }
  scope :published, -> { where(status_id: Status::PUBLISHED.id) }

  def to_param
    slug || id
  end

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
    self.status_id = Status::DRAFT.id unless status_id
  end

  def create_slug
    update_attribute :slug, "#{subject.parameterize}-#{id}" unless self.slug.present? || subject.nil?
  end
end
