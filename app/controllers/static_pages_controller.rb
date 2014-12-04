class StaticPagesController < ApplicationController
  def home
  	# @article = current_user.articles.build if signed_in?
  	@user = current_user
  	@articles = Article.all
  end

  def search
      @articles = Article.search params[:search]
  end

  def help
  end

  def about
  end

  def contact
  end
end
