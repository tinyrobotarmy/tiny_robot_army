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

  describe 'GET #new' do
    subject { get :new }

    it 'should expose a new Post as @post for editing' do
      subject
      assigns(:post).should be_new_record
    end
  end

  describe 'POST #create' do
    subject { post :create, post_attributes }

    context 'when attributes are invalid' do
      let(:post_attributes) { {subject: 'awesome post'} }
      it 'should re-render the new template' do
        subject 
        response.should render_template(:new)
      end
    end

    context 'when attributes are valid' do
      let(:post_attributes) { {subject: 'good one', body: 'great bod'} }
      it 'should be a success' do
        subject
        response.code.should == '200'
      end
    end
  end
end