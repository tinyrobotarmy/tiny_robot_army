require "spec_helper"

describe PostsController do
  describe 'GET #index' do
    subject { get :index }
    it 'should make paginated posts available for rendering' do
      Post.stub_chain(:order, :paginate).and_return 'some posts'
      subject
      expect(assigns(:posts)).to eql 'some posts'
    end

    it 'should render the index template' do
      subject
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    subject { get :show, id: post.id }
    let(:post) { instance_double('Post', id: 123) }
    before{ Post.stub(:find).and_return post }

    it 'should make a new comment available for rendering' do
      subject
      expect(assigns(:new_comment)).to be_a Comment
    end

    it 'should make the post available for rendering' do
      subject
      expect(assigns(:post)).to eql post
    end

    it 'should render the show template' do
      subject
      response.should render_template :show
    end
  end
end
