require "spec_helper"

describe PostsController, :type => :controller do
  describe 'GET #index' do
    subject { get :index }
    before do
      3.times{ FactoryGirl.create :post }
    end
    it 'should make paginated posts available for rendering' do
      subject
      expect(assigns(:posts).count).to eql 3
    end

    it 'should render the index template' do
      subject
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    subject { get :show, id: post.to_param }
    let(:post) { FactoryGirl.create :post }
    before{ allow(Post).to receive(:find_by_slug).with('new-post-1').and_return post }

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
      expect(response).to render_template :show
    end
  end
end
