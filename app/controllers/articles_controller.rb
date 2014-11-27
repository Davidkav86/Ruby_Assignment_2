class ArticlesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	def index
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.find(params[:id])
	end

	def show
		@article = Article.find(params[:id])
		@user = User.find(params[:id]) 
		@user_name = @user.name
		@image = Image.new(params[:image])
		respond_to do |format|      
			if @image.save         
				format.html { redirect_to @image, notice: 'Image was successfully created.' } 
			else      
				format.html { render action: "new" }  
			end    
		end
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "Article Published!"
			redirect_to current_user
		else
			flash[:error] = "Artile has not been Published"
			render 'users/show_admin'
		end
	end

	def destroy
	end

	private

	def article_params
		params.require(:article).permit(:title, :content)
	end
end