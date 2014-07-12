require 'rails_helper'
extend ActionDispatch::TestProcess

describe Admin::ImagesController, :type => :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
    allow(controller).to receive(:require_admin!).and_return true
    allow(controller).to receive(:current_user).and_return double(:user)
  end

  def valid_attributes
    { 'file' => fixture_file_upload("/files/image.jpg", 'image/jpg') }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all images as @images" do
      allow(Image).to receive(:all).and_return double(:images, order: 'all images')
      get :index, {}, valid_session
      expect(assigns(:images)).to eq('all images')
    end
  end

  describe "GET show" do
    it "assigns the requested image as @image" do
      allow(Image).to receive(:find).and_return 'an image'
      get :show, {:id => '1'}, valid_session
      expect(assigns(:image)).to eq('an image')
    end
  end

  describe "GET new" do
    it "assigns a new image as @image" do
      get :new, {}, valid_session
      expect(assigns(:image)).to be_a_new(Image)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Image" do
        expect {
          post :create, {:image => valid_attributes}, valid_session
        }.to change(Image, :count).by(1)
      end

      it "assigns a newly created image as @image" do
        post :create, {:image => valid_attributes}, valid_session
        expect(assigns(:image)).to be_a(Image)
        expect(assigns(:image)).to be_persisted
      end

      it "redirects to the created image" do
        post :create, {:image => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, Image.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved image as @image" do
        post :create, {:image => { "file" => "" }}, valid_session
        expect(assigns(:image)).to be_a_new(Image)
      end

      it "re-renders the 'new' template" do
        post :create, {:image => { "file" => "" }}, valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested image" do
      image = Image.create!(valid_attributes)
      expect {
        delete :destroy, {:id => image.to_param}, valid_session
      }.to change(Image, :count).by(-1)
    end

    it "redirects to the images list" do
      image = Image.create! valid_attributes
      delete :destroy, {:id => image.to_param}, valid_session
      expect(response).to redirect_to(admin_images_url)
    end
  end

end
