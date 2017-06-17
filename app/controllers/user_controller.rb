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
    puts "USERNAME: #{params[:username]}"
    user = User.new(
      username: params[:username],
      password: params[:password]
      )
    respond_to do |format|
      if user.save
        session[:user_id] = user.id
        format.html {redirect_to '/users', notice: 'User create successfully'}
      else
        flash[:warning] = "Invalid email or password"
        format.html{ render :new }
      end
    end
  end

  

end
