class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user
    redirect_to new_session_path, alert: 'Please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?
  # adding this line akes this method accessible in view files. Because this method is in the Application Controller , then its' accessible in all views.

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?  ###this limits the number of hits to the database every time you make a call to User.find
   end
    helper_method :current_user

end
