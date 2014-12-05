class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @article = Article.find_by(id: get_article_id)
    @comment.article_id = @article.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to "/articles/#{@article.id}"
    else
      flash[:error] = "Error occured while posting comment"
      render @article
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @article = Article.find_by(id: get_article_id)
    redirect_to "/articles/#{@article.id}"
  end

  def edit
    @user = current_user
    @comment = Comment.find(params[:id])
  end

  def update
    @article = Article.find_by(id: get_article_id)
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated"
      redirect_to @article
    else
      flash[:error] = "Error Updating Comment"
      render 'edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
