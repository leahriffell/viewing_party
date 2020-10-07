class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    flash[:success] = "Welcome, #{user.email}!"
    redirect_to(dashboard_path)
  end
end