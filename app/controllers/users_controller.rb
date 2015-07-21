class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :init_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end

  def show
    @activities = @user.activities.recent.paginate page: params[:page]
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

  def destroy
    if @user.destroy
      flash[:success] = t "destroy_user.success"
    else
      flash[:danger] = t "destroy_user.error"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, 
                          :password_confirmation, :avatar, :role
  end

  def init_user
    @user = User.friendly.find params[:id]
  end
  
end
