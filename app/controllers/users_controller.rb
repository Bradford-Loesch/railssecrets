class UsersController < ApplicationController
  def new
    unless session[:login]
      session[:login] = false
    end
    render 'users/new'
  end
  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to '/users/new'
    end
  end
  def show
    @user = User.find(params[:id])
    render 'users/show'
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(session[:login])
    user.name = params[:name]
    user.email = params[:email]
    user.save
    redirect_to "/users/#{user.id}"
  end
  def destroy
    user = User.find(session[:login])
    user.destroy
    session[:login] = false
    redirect_to '/sessions/new'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
