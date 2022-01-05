require 'spec_helper'

describe CommentsController, type: :controller do

  describe 'GET #show' do
    subject { get :show, params: {post_id: comment.post_id, id: comment.to_param } }
      let(:comment) { FactoryGirl.create :comment }

    it "assigns the requested comment as @comment" do
      subject
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe 'POST #create' do
    #setup controller access and current_user
    before do
      allow(controller).to receive(:require_user!).and_return true
      allow(controller).to receive(:current_user).and_return FactoryGirl.create :user
    end
    let(:existing_post) { FactoryGirl.create :post }
    
    describe 'with valid params' do
      subject { post :create, params: all_attributes }
      let(:all_attributes) { { post_id: existing_post.to_param, comment: {body: FFaker::Lorem.paragraph } } }

      it 'creates a new comment' do
        subject
        expect(Comment.all.count).to eq(1)
      end
    end
  end
end