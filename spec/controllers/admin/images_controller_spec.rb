require 'rails_helper'
extend ActionDispatch::TestProcess

describe Admin::ImagesController, :type => :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
    allow(controller).to receive(:require_admin!).and_return true
    allow(controller).to receive(:current_user).and_return double(:user)
  end

  def valid_attributes
    { 'file' => fixture_file_upload("image.jpg", 'image/jpg') }
  end

  describe "GET index" do
    it "assigns all images as @images" do
      allow(Image).to receive(:all).and_return double(:images, order: 'all images')
      get :index, {}
      expect(assigns(:images)).to eq('all images')
    end
  end

  describe "GET show" do
    it "assigns the requested image as @image" do
      allow(Image).to receive(:find).and_return 'an image'
      get :show, params: {:id => '1'}
      expect(assigns(:image)).to eq('an image')
    end
  end

  describe "GET new" do
    it "assigns a new image as @image" do
      get :new, {}
      expect(assigns(:image)).to be_a_new(Image)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Image" do
        expect {
          post :create, params: {:image => valid_attributes}
        }.to change(Image, :count).by(1)
      end

      it "assigns a newly created image as @image" do
        post :create, params: {:image => valid_attributes}
        expect(assigns(:image)).to be_a(Image)
        expect(assigns(:image)).to be_persisted
      end

      it "redirects to the created image" do
        post :create, params: {:image => valid_attributes}
        expect(response).to redirect_to([:admin, Image.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved image as @image" do
        post :create, params: {:image => { "file" => "" }}
        expect(assigns(:image)).to be_a_new(Image)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:image => { "file" => "" }}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested image" do
      image = Image.create!(valid_attributes)
      expect {
        delete :destroy, params: {:id => image.to_param}
      }.to change(Image, :count).by(-1)
    end

    it "redirects to the images list" do
      image = Image.create! valid_attributes
      delete :destroy, params: {:id => image.to_param}
      expect(response).to redirect_to(admin_images_url)
    end
  end

end
