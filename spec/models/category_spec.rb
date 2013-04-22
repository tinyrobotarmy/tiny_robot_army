require 'spec_helper'

describe Category do
  it { should have_and_belong_to_many :posts }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }
  it { should validate_uniqueness_of :slug }
end
