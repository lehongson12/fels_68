class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.role = 0
    if @user.save
      log_in @user
      flash[:success] = I18n.t "signup.signup_success"
      redirect_to @user
    else
      render "new"
    end
  end
  def update
    if @user.update_attributes user_params
      flash[:success] = I18n.t "edit_user.update_success"
      redirect_to @user
    else
      render "edit"
    end
  end
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                   :password_confirmation,:avatar
  end
  def set_user
    @user = User.find params[:id]
  end
end

