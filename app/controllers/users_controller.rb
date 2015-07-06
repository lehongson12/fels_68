class UsersController < ApplicationController
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
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                   :password_confirmation
  end
end
