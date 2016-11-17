class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:login] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = "Invalid username or password."
      redirect_to '/sessions/new'
    end
  end

  def logout
    session[:login] = false
    redirect_to '/sessions/new'
  end
end
