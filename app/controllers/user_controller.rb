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
    @user = User.new
    render 'new.html.erb'
  end

  #create new user with parameter pass in
  def create
    @user = User.new(params.require(:user).permit(:username, :password))
    respond_to do |format|
      if @user.save
        format.html {redirect_to '/users', notice: 'User create successfully'}
      else
        format.html{ render :new }
      end
    end
  end

  

end
