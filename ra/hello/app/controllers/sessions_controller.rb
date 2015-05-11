class SessionsController < ApplicationController
  def new
  end

  ## login
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid login/password combination'
      redirect_to :action => 'new', :alert => 'Invalid login/password combination'
    end
  end

  ## logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'You successfully logged out'
  end
end
