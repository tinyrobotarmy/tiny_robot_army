require "rails_helper"

describe Status, :type => :model do
  describe "object equality" do
    specify {expect(Status::DRAFT).to be === Status::DRAFT}
    specify {expect(Status.new(0, 'Draft')).not_to be === Status::DRAFT}
  end

  describe '#all' do
    it 'should return 11 statuss' do
      expect(Status.all.size).to eq(2)
    end
  end

  describe '#find' do
    it 'should return the status with the id provided' do
      expect(Status.find(1).id).to eq(1)
    end

    it 'should raise RecordNotFound id there is no status with the id provided' do
      expect{ Status.find(3) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#find_by_id' do
    it 'should return the status with the id provided' do
      expect(Status.find_by_id(0).id).to eq(0)
    end

    it 'should return nil if there is no status with the id provided' do
      expect(Status.find_by_id(20)).to be_nil
    end
  end
end
