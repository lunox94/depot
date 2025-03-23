class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end


  def create
    ensure_default_user if User.count.zero?

    user_params = params.permit(:email_address, :password)
    return redirect_to new_session_path, alert: "Try another email address or password." unless (user = User.authenticate_by(user_params))

    start_new_session_for(user)
    redirect_to after_authentication_url
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private

  def ensure_default_user
    user_params = params.permit(:email_address, :password).merge(name: "Default")
    User.create!(user_params)
  end
end
