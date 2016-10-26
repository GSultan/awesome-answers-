class UsersController < ApplicationController

  def index
    cookies[:last_visited] = Time.now
    cookies[:lucky_number] = rand(100)
  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name, :last_name, :email, :password, :pasword_confirmation])
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Thank you for signing up'
    else
      render :new
      #:new in this instance is the new template , new.html.erb
    end
  end

end
