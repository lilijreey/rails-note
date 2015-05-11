class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user, :logged_in?

  def authorize
    unless current_user()
      redirect_to login_path, notice: 'Please log in to continue'
      return false
    end
  end

  def authorize_admin!
    authorize 

    unless @current_user.is_admin?
      flash[:alert] = 'You must be an admin to do that.'
      redirect_to root_path
      return false
    end
  end

  def logged_in?
    @current_user.is_a? User
  end


end
