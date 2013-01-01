require "spec_helper"

describe Comment do
  it { should validate_presence_of :body }

  it { should belong_to :author }
  it { should belong_to :post }
end