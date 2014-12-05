class ArticlesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

    $id

	def index
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.find(params[:id])
	end

	def show
		@article = Article.find(params[:id])
		store_article_id @article.id
		@user = User.find_by(id: @article.user_id)
		@comments = @article.comments.paginate(page: params[:page])
		@comment = current_user.comments.build if signed_in? 
	end

	def create
		@user = current_user
		@users = User.all
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
	  @article = Article.find(params[:id])
      @article.destroy
      redirect_to current_user
	end

	def edit
		@user = current_user
		@article = Article.find_by(id: get_article_id)
	end

	def update
		@article = Article.find_by(id: get_article_id)
		if @article.update_attributes(article_params)
			flash[:success] = "Article updated"
			redirect_to @article
		else
			flash[:error] = "Error Updating Article"
			render 'edit'
		end
	end

	private

	def article_params
		params.require(:article).permit(:title, :content, :genre)
	end
end