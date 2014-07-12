require 'rails_helper'

describe Category, :type => :model do
  it { is_expected.to have_and_belong_to_many :posts }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_uniqueness_of :title }
  it { is_expected.to validate_uniqueness_of :slug }
end
