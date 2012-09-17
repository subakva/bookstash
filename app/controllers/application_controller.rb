class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  protected

  def require_current_user
    unless current_user.present?
      flash[:alert] = 'Please sign in.'
      redirect_to signin_url
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end

  def current_user=(user)
    if user.nil?
      @current_user = session[:user_id] = nil
    else
      session[:user_id] = user.id
      @current_user = user
    end
  end
end
