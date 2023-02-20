class SessionsController < ApplicationController
  
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
      @current_user.reset_session_token! if logged_in?
      session[:session_token] = nil
      @current_user = nil
      redirect_to new_session_url
  end

end