class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.email}!"
      redirect_to '/dashboard'
    else
      flash[:error] = @user.errors.full_messages_to_sentence
      if @user.errors.details.keys.include?(:email)
        @user.email = ''
      end
    render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
