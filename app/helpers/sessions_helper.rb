module SessionsHelper
  def sign_in(user_email)
    cookies.permanent.signed[:user_email] = user_email
  end

  def sign_out
    cookies.delete(:user_email)
  end

  def signed_in?
    cookies.signed[:user_email]
  end

  def allowed_user?(user_email)
    user_email.end_with?("@#{APP_CONFIG['organization_domain']}")
  end

  def current_user_email
    cookies.signed[:user_email]
  end

  def signed_in_user
    unless cookies.signed[:user_email]
      store_location
      redirect_to signin_path
    end 
  end 

  def auth_hash
    request.env['omniauth.auth']
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
