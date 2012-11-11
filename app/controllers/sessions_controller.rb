class SessionsController < ApplicationController
  def create
    user_email = auth_hash.info['email']

    if allowed_user?(user_email)
      sign_in user_email
      flash[:notice] = 'Signed in successfully!'
      redirect_back_or root_url
    else
      redirect_to signin_path, flash: {
        error: "Invalid domain! Please login with your " +
               "#{APP_CONFIG['organization_name']} Google account."
      }
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
