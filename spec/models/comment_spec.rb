require "rails_helper"

describe Comment, :type => :model do
  it { is_expected.to validate_presence_of :body }

  it { is_expected.to belong_to :author }
  it { is_expected.to belong_to :post }
end
