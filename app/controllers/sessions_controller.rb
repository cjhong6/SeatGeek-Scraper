class SessionsController < ApplicationController
  def new
    render "new.html.erb"
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Successfully log in!'
      redirect_to '/'
    else
      flash[:warning] = "Invalid email or password"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully log out"
    redirect_to '/login'
  end
end
