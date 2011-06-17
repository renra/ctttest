class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  # do through CanCan
  #before_filter :require_auth

  rescue_from CanCan::AccessDenied do |exc|
    flash[:notice] = current_user ? 'Access denied. Shoo!' : 'Please log in first'
    redirect_path = current_user ? projects_path : login_path
    redirect_to redirect_path
  end

  protected
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  #def current_ability
  #  Ability.new(current_user)
  #end

  def require_auth
    unless current_user
      flash[:notice] = 'You must authenticate first'
      redirect_to login_path
    end
  end
end
