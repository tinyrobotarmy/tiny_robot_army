require "spec_helper"

describe Admin::PostsController do
  before do
    controller.stub(:authenticate_user!).and_return true
    controller.stub(:authenticate_admin!).and_return true
    controller.stub(:current_user).and_return stub_model(User)
  end

  describe 'GET #new' do
    subject { get :new }

    it 'should expose a new Post as @post for editing' do
      subject
      assigns(:post).should be_new_record
    end
  end

  describe 'POST #create' do
    subject { post :create,post: post_attributes }

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
        response.should redirect_to post_path(assigns(:post))
      end
    end
  end
end