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
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
