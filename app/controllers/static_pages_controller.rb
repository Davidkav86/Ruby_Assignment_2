class StaticPagesController < ApplicationController
  def home
  	@article = current_user.articles.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
