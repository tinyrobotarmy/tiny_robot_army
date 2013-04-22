require "spec_helper"

describe PostsController do
  describe 'GET #index' do
    subject { get :index }
    it 'should make paginated posts available for rendering' do
      Post.stub_chain(:order, :paginate).and_return 'some posts'
      subject
      assigns(:posts).should == 'some posts'
    end

    it 'should render the index template' do
      subject
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    subject { get :show, id: post.id }
    let(:post) { stub_model(Post) }
    before{ Post.stub(:find).and_return post }

    it 'should make a new comment available for rendering' do
      subject
      assigns(:new_comment).should be_a Comment
    end

    it 'should make the post available for rendering' do
      subject
      assigns(:post).should == post
    end

    it 'should render the show template' do
      subject
      response.should render_template :show
    end
  end
end
