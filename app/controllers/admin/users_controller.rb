class Admin::UsersController < Admin::AdminController
  respond_to :html
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    respond_with :admin, @users = User.order('created_at DESC')
  end

  def show
    respond_with :admin, @user
  end

  def new
    respond_with :admin, @user = User.new, layout: !request.xhr?
  end

  def create
    respond_with :admin, @user = User.create(user_params)
  end

  def edit
    respond_with :admin, @user
  end

  def update
    @user.update(user_params)
    respond_with :admin, @user
  end

  def destroy
    @user.destroy
    respond_with(:admin, @user)
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
