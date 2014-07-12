require 'rails_helper'

describe Image, :type => :model do
  it { is_expected.to validate_presence_of :file }
end
