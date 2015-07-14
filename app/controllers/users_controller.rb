class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end

  def show
    @user = User.find params[:id]  
  end

  def index
    @users = User.paginate page: params[:page], per_page: Settings.length.page
  end

  def create
    @user = User.new user_params
    @user.role = 0
    if @user.save
      log_in @user
      flash[:success] = t"signup.signup_success"
      redirect_to @user
    else
      render :new
    end
  end
  
  def update
    if @user.update_attributes user_params
      flash[:success] = t"edit_user.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, 
                          :password_confirmation, :avatar, :role
  end

  def set_user
    @user = User.find params[:id]
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login.require"
      redirect_to login_url
    end
  end

end
