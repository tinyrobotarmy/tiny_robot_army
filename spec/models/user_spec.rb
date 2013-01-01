require "spec_helper"

describe User do
  it { should have_many :posts }
  it { should have_many :comments }

  describe "#full_name" do
    subject { User.new({first_name: 'Jethro', last_name: 'Tull'}).full_name }

    it "should return first and last name concatenated" do
      subject.should == 'Jethro Tull'
    end
  end
end