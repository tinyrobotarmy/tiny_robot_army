require "spec_helper"

describe Admin::PostsController, :type => :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
    allow(controller).to receive(:require_admin!).and_return true
    allow(controller).to receive(:current_user).and_return User.new
  end

  def valid_attributes(add_or_override={})
    {subject: 'good one', body: 'great bod'}.merge(add_or_override)
  end

  describe 'GET #index' do
    subject { get :index }
    it 'should make posts available for rendering' do
      allow(Post).to receive(:order).and_return 'all posts'
      subject
      expect(assigns(:posts)).to eq('all posts')
    end

    it 'should render index template' do
      subject
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    subject { get :show, id: post.id }
    let(:post) { double(:post, id: 356) }
    before { allow(Post).to receive(:find).and_return post }
    it 'should make the post available for rendering' do
      subject
      expect(assigns(:post)).to eq(post)
    end

    it 'should render show template' do
      subject
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'should expose a new Post as @post for editing' do
      subject
      expect(assigns(:post)).to be_new_record
    end

    it 'should render the new template' do
      subject
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    subject { post :create, post: post_attributes }

    context 'when attributes are invalid' do
      let(:post_attributes) { {subject: 'awesome post'} }
      it 'should re-render the new template' do
        subject
        expect(response).to render_template(:new)
      end
    end

    context 'when attributes are valid' do
      let(:post_attributes) { valid_attributes }
      it 'should be a success' do
        subject
        expect(response).to redirect_to admin_post_path(assigns(:post))
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, id: post.id }
    let(:post) { Post.create!(valid_attributes)}
    it 'should make the post available for editing' do
      subject
      expect(assigns(:post)).to eq(post)
    end

    it 'should render the edit template' do
      subject
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    subject { put :update, id: post.id, post: attributes }
    let(:post) { Post.create!(valid_attributes)}
    context 'with valid attributes' do
      let(:attributes) { valid_attributes(subject: 'new subject') }

      it 'should update the post' do
        subject
        expect(post.reload.subject).to eq('new subject')
      end

      it 'should redirect to the post show' do
        subject
        expect(response).to redirect_to admin_post_path(post)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { {subject: ''} }
      it 'should render the edit template' do
        subject
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, id: post.id }
    let(:post) { Post.new(id: 156) }
    before { allow(Post).to receive(:find).and_return post }

    it 'should destroy the post' do
      expect(post).to receive(:destroy)
      subject
    end

  end
end
