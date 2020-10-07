class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to(dashboard_path)
    else
      invalid_credentials_redirect
    end
  end

  private

  def invalid_credentials_redirect
    flash[:error] = 'Incorrect email or password.'
    redirect_to(root_path)
  end
end
