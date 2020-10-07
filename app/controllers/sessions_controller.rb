class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to(dashboard_path)
    elsif !user 
      flash[:error] = "No user exists with that email address."
      redirect_to(root_path)
    else 
      flash[:error] = "Incorrect password"
      redirect_to(root_path)
    end
  end
end