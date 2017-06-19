class UserController < ApplicationController

  #get all the users
  def index
    @users = User.all
    render 'index.html.erb'
  end

  #show detailed info about user
  def show
    @user = User.find(params[:id])
    render 'show.html.erb'
  end

  #create new user
  def new
    render 'new.html.erb'
  end

  #create new user with parameter pass in
  def create
    user = User.new(
      username: params[:username],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
      )

      if user.save
        session[:user_id] = user.id
        flash[:success] = "User create successfully"
        redirect_to '/'
      else
        flash[:warning] = "Invalid email or password"
        redirect_to '/signup'
      end
  end
end