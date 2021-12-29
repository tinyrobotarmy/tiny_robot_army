require 'rails_helper'

describe Admin::CategoriesController, :type => :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
    allow(controller).to receive(:require_admin!).and_return true
    allow(controller).to receive(:current_user).and_return double(:user)
  end
  def valid_attributes
    { "title" => "new title" }
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = Category.create! valid_attributes
      get :index, {}
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :show, params: {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :edit, params: {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: {:category => valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, params: {:category => valid_attributes}
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, params: {:category => valid_attributes}
        expect(response).to redirect_to([:admin, Category.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, params: {:category => { "title" => "" }}
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:category => { "title" => "" }}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        category = Category.create! valid_attributes
        expect_any_instance_of(Category).to receive(:update).with({ "title" => "" })
        put :update, params: {:id => category.to_param, :category => { "title" => "" }}
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, params: {:id => category.to_param, :category => valid_attributes}
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, params: {:id => category.to_param, :category => valid_attributes}
        expect(response).to redirect_to([:admin, category])
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        put :update, params: {:id => category.to_param, :category => { "title" => "" }}
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        category = Category.create! valid_attributes
        put :update, params: {:id => category.to_param, :category => { "title" => "" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, params: {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, params: {:id => category.to_param}
      expect(response).to redirect_to(admin_categories_url)
    end
  end

end
