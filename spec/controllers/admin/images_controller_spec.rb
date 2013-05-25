require 'spec_helper'
extend ActionDispatch::TestProcess

describe Admin::ImagesController do
  before do
    controller.stub(:authenticate_user!).and_return true
    controller.stub(:require_admin!).and_return true
    controller.stub(:current_user).and_return stub_model(User)
  end

  def valid_attributes
    { 'file' => fixture_file_upload("/files/image.jpg", 'image/jpg') }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all images as @images" do
      Image.stub(:all).and_return 'all images'
      get :index, {}, valid_session
      assigns(:images).should eq('all images')
    end
  end

  describe "GET show" do
    it "assigns the requested image as @image" do
      Image.stub(:find).and_return 'an image'
      get :show, {:id => '1'}, valid_session
      assigns(:image).should eq('an image')
    end
  end

  describe "GET new" do
    it "assigns a new image as @image" do
      get :new, {}, valid_session
      assigns(:image).should be_a_new(Image)
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
        assigns(:image).should be_a(Image)
        assigns(:image).should be_persisted
      end

      it "redirects to the created image" do
        post :create, {:image => valid_attributes}, valid_session
        response.should redirect_to([:admin, Image.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved image as @image" do
        post :create, {:image => { "file" => "" }}, valid_session
        assigns(:image).should be_a_new(Image)
      end

      it "re-renders the 'new' template" do
        post :create, {:image => { "file" => "" }}, valid_session
        response.should render_template(:new)
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
      response.should redirect_to(admin_images_url)
    end
  end

end
