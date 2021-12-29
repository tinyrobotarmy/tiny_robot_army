require "spec_helper"

describe PostsController, :type => :controller do
  describe 'GET #index' do
    subject { get :index }
    before do
      2.times{ FactoryGirl.create :published_post }
      FactoryGirl.create :post
    end
    it 'should make paginated list of published posts available for rendering' do
      subject
      expect(assigns(:posts).count).to eql 2
    end

    it 'should render the index template' do
      subject
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: post.to_param } }
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
