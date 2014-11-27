class UsersController < ApplicationController

  def show
    # initialise @users so it can be used in the html to create a list
    @users = User.all
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page])
    is_admin = @user.is_admin
    
    if is_admin
      render 'show_admin'
    else
    end
  end

  def new
    @user = User.new
  end

  def create
    if current_user.is_admin == true
      create_admin
    else
      @user = User.new(user_params)
      if @user.save
        @user.update_attributes(is_admin: false)
        @user.save
        sign_in @user # calls the sign_in method in the sessions_helper. Signs a user in once they have signed up
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
    end
  end

  def index
    @users = User.all
  end

  def show_admin
    @users = User.all
  end

  def add_article
    @user = current_user
    @article = current_user.articles.build if signed_in?
    @articles = @user.articles.paginate(page: params[:page])
    @image = Image.new(params[:image])
    respond_to do |format|      
      if @image.save         
        format.html { redirect_to @image, notice: 'Image was successfully created.' } 
      else      
        format.html { render action: "new" }  
      end    
    end
  end

  def new_admin
    @user = User.new
  end

  def create_admin
    @user = User.new(user_params)
    @user.update_attributes(is_admin: true)
    if @user.save
      flash[:success] = "New Administrator Account Created!"
      redirect_to current_user
    else
      render 'create_admin'
    end
  end

  private
  # This method returns a version of the params hash with only the permitted attributes (while raising an error if the :user attribute is missing). 
  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation,:is_admin)
  end
end
