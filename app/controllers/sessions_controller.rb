class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) # pulls the user out of the database using the submitted email address
    if user && user.authenticate(params[:session][:password]) # the if statement is true only if a user with the given email both exists 
    	                                                      #  in the database and has the given password, exactly as required.
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination' #flash.now ensures that the flash is only shown on the rendered page.
      render 'new'
    end
  end

  def destroy
    sign_out # in sessions helper
    redirect_to root_url
  end
end
