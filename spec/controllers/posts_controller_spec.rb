require "spec_helper"

describe PostsController do
  describe 'GET #index' do

    it 'should make paginated posts available for rendering' do
      Post.stub_chain(:order, :paginate).and_return 'some posts'
      get :index
      assigns(:posts).should == 'some posts'
    end

    it 'should render the index template' do
      get :index
      response.should render_template :index
    end

  end
end
