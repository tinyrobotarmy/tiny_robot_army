require "spec_helper"

describe Admin::PostsController do
  before do
    controller.stub(:authenticate_user!).and_return true
    controller.stub(:authenticate_admin!).and_return true
    controller.stub(:current_user).and_return stub_model(User)
  end

  def valid_attributes(add_or_override={})
    {subject: 'good one', body: 'great bod'}.merge(add_or_override)
  end

  describe 'GET #new' do
    subject { get :new }

    it 'should expose a new Post as @post for editing' do
      subject
      assigns(:post).should be_new_record
    end

    it 'should render the new template' do
      subject
      response.should render_template :new
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
      let(:post_attributes) { valid_attributes }
      it 'should be a success' do
        subject
        response.should redirect_to admin_post_path(assigns(:post))
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, id: post.id }
    let(:post) { Post.create!(valid_attributes)}
    it 'should make the post available for editing' do
      subject
      assigns(:post).should == post
    end

    it 'should render the edit template' do
      subject
      response.should render_template :edit
    end
  end

  describe 'PUT #update' do
    subject { put :update, id: post.id, post: attributes }
    let(:post) { Post.create!(valid_attributes)}
    context 'with valid attributes' do
      let(:attributes) { valid_attributes(subject: 'new subject') }

      it 'should update the post' do
        subject
        post.reload.subject.should == 'new subject'
      end

      it 'should redirect to the post show' do
        subject
        response.should redirect_to admin_post_path(post)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { {subject: ''} }
      it 'should render the edit template' do
        subject
        response.should render_template :edit
      end
    end
  end
end
