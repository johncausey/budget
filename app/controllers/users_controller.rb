class UsersController < ApplicationController
  before_filter do
    params[:user] &&= user_params
  end
  load_and_authorize_resource

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to current_month_path, notice: "Welcome to RainyBudget!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to current_month_path, :notice => "Successfully updated account information."
    else
      redirect_to current_month_path, :flash => { :alert => "There was an error updating your user information." }
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
  
end
