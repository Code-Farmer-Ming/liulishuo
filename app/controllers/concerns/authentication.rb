module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?, :current_user
  end

  module ClassMethods
  end

  def authenticate!
    unless signed_in?
      session['return_to'] = request.fullpath
      redirect_to login_path
    end
  end

  def signed_in?
    !!current_user
  end
      
  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def sign_in(user)
    session[:user_id] = user.to_param

  end
  
  def sign_out
    session[:user_id] =  @current_user = nil
  end
  
  def return_to_path
    session['return_to'] || root_path
  end

end
