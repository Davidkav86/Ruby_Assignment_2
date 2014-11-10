class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  # This method returns a version of the params hash with only the permitted attributes (while raising an error if the :user attribute is missing). 
  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
