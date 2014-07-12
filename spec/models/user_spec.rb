require "rails_helper"

describe User, :type => :model do
  it { is_expected.to have_many :posts }
  it { is_expected.to have_many :comments }

  describe "#full_name" do
    subject { User.new({first_name: 'Jethro', last_name: 'Tull'}).full_name }

    it "should return first and last name concatenated" do
      expect(subject).to eq('Jethro Tull')
    end
  end
end
