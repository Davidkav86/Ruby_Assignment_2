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
		@user = User.find_by(id: @article.user_id) 
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "Article Published!"
			redirect_to current_user
		else
			flash[:error] = "Error Publishing Article"
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