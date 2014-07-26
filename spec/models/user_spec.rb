require "rails_helper"

describe User, :type => :model do
  it { is_expected.to have_many :posts }
  it { is_expected.to have_many :comments }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :password }

  describe "#full_name" do
    subject { User.new({first_name: 'Jethro', last_name: 'Tull'}).full_name }

    it "should return first and last name concatenated" do
      expect(subject).to eq('Jethro Tull')
    end
  end
end
