require "spec_helper"

describe Status do
  describe "object equality" do
    specify {Status::DRAFT.should === Status::DRAFT}
    specify {Status.new(0, 'Draft').should_not === Status::DRAFT}
  end

  describe '#all' do
    it 'should return 11 statuss' do
      Status.all.should have(2).items
    end
  end

  describe '#find' do
    it 'should return the status with the id provided' do
      Status.find(1).id.should == 1
    end

    it 'should raise RecordNotFound id there is no status with the id provided' do
      expect{ Status.find(3) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#find_by_id' do
    it 'should return the status with the id provided' do
      Status.find_by_id(0).id.should == 0
    end

    it 'should return nil if there is no status with the id provided' do
      Status.find_by_id(20).should be_nil
    end
  end
end
