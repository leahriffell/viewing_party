class FriendshipsController < ApplicationController
  before_action :require_user

  def create
    if !User.find_by(email: params[:friend_email])
      flash[:error] = "I'm sorry, your friend cannot be found."
    elsif params[:friend_email] == current_user.email
      flash[:error] = "Sorry, but you can't add yourself as friend, silly!"
    elsif current_user.friends_with?(User.find_by(email: params[:friend_email]))
      flash[:error] = 'This person is already your friend :)'
    else
      new_friend = User.find_by(email: params[:friend_email])
      current_user.add_friend(new_friend)
    end
    redirect_to dashboard_path
  end
end
