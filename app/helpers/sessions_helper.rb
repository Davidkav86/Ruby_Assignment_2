module SessionsHelper

  $id
  
  def sign_in(user)
    remember_token = User.new_remember_token # create a new token
    # .permanent - set the expiration to 20.years.from_now
    cookies.permanent[:remember_token] = remember_token # place the raw token in the browser cookies
    user.update_attribute(:remember_token, User.digest(remember_token)) # save the hashed token to the database
    self.current_user = user # set the current user equal to the given user ---- not needed because of the immediate redirect in the create action 
  end

  def signed_in?
    !current_user.nil?
  end

  # the last line of the sign_in method is calling this. It is converted into current_user=(...)
  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    # ts effect is to set the @current_user instance variable to the user corresponding to the remember token, but only if @current_user is undefined
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    # change the users remember_token in case the cookie has been stolen, as it could still be used to authorize a user
    current_user.update_attribute(:remember_token,User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def store_article_id(current_id)
    $id = current_id
  end

  def get_article_id
    $id
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
end
