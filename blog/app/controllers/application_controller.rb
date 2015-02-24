class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :ensure_logged_in
  def current_user
    @_user = User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_logged_in
    if current_user.nil?
      session.delete(:user_id)
      redirect_to '/'
    end
  end
end
