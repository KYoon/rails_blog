class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:user][:username], params[:user][:password])
    if user
      session[:user_id] = user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    sessions.delete(:user_id)
    redirect_to root
  end
end
