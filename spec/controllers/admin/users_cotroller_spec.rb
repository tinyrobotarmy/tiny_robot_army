require "spec_helper"

describe Admin::UsersController, :type => :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
    allow(controller).to receive(:require_admin!).and_return true
    allow(controller).to receive(:current_user).and_return User.new
  end

  def valid_attributes(add_or_override={})
    {email: 'test@test.tt', first_name: 'first', last_name: 'last', password: 'secret'}.merge(add_or_override)
  end

  describe 'GET #index' do
    subject { get :index }
    it 'should make users available for rendering' do
      allow(User).to receive(:order).and_return 'all users'
      subject
      expect(assigns(:users)).to eq('all users')
    end

    it 'should render index template' do
      subject
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: user.id } }
    let(:user) { double(:user, id: 356) }
    before { allow(User).to receive(:find).and_return user }
    it 'should make the user available for rendering' do
      subject
      expect(assigns(:user)).to eq(user)
    end

    it 'should render show template' do
      subject
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'should expose a new User as @user for editing' do
      subject
      expect(assigns(:user)).to be_new_record
    end

    it 'should render the new template' do
      subject
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { user: user_attributes } }

    context 'when attributes are invalid' do
      let(:user_attributes) { {first_name: 'awesome user'} }
      it 'should re-render the new template' do
        subject
        expect(response).to render_template(:new)
      end
    end

    context 'when attributes are valid' do
      let(:user_attributes) { valid_attributes }
      it 'should be a success' do
        subject
        expect(response).to redirect_to admin_user_path(assigns(:user))
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: user.id } }
    let(:user) { User.create!(valid_attributes)}
    it 'should make the user available for editing' do
      subject
      expect(assigns(:user)).to eq(user)
    end

    it 'should render the edit template' do
      subject
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: { id: user.id, user: attributes } }
    let(:user) { User.create!(valid_attributes)}
    context 'with valid attributes' do
      let(:attributes) { valid_attributes(first_name: 'new name') }

      it 'should update the user' do
        subject
        expect(user.reload.first_name).to eq('new name')
      end

      it 'should redirect to the user show' do
        subject
        expect(response).to redirect_to admin_user_path(user)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { {email: ''} }
      it 'should render the edit template' do
        subject
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: user.id } }
    let(:user) { User.new(id: 156) }
    before { allow(User).to receive(:find).and_return user }

    it 'should destroy the user' do
      expect(user).to receive(:destroy)
      subject
    end

  end
end
