require "spec_helper"

describe PostsController do
  describe 'GET #index' do
    subject { get :index }

    it 'should expose @posts for rendering' do
      subject
      assigns(:posts).should == []
    end

    it 'should order posts by created_at date' do
      Post.should_receive(:order).with('created_at DESC')
      subject
    end
  end
  
end