class BidController < ApplicationController

  #Get all the bids
  def index
    if current_user
      @bid = current_user.bids
      render 'index.html.erb'
    else
      flash[:warning] = "Please login"
      redirect_to '/login'
    end
  end

  #show deatiled info about the bid
  def show
    @bid = Bid.find_by(id: params[:id])
    render 'show.html.erb'
  end

  #create new bid
  def new
    @bid = Bid.new
    render 'new.html.erb'
  end

  #create new bid with parameter pass in 
  def create
    bid = Bid.new(user_id:  session[:user_id], lowest_price: params[:lowest_price], offer_price: params[:offer_price], event_name: params[:event_name], event_id: params[:event_id])
    if session[:user_id] == current_user.id
      bid.save
      send_message("14155137961", "your bid has been created sit back while we find you your ticket")
      #restart_jobs
      redirect_to '/bids'
      flash[:success] = "New bid added"
    else
      flash[:danger] = "your not logged in"
      redirect_to '/login'
    end
  end

  #update bid offer_price
  def update
    bid = current_user.bids.find_by(id: params[:id])
    bid.offer_price = params[:offer_price]
    bid.save
    flash[:success] = "update bid successfully"
    redirect_to '/bids' 
  end

  #delete a bid
  def destroy
    bid = current_user.bids.find_by(id: params[:id])
    bid.destroy
    flash[:success] = "destroy bid successfully"
    redirect_to '/bids'
  end

  def restart_jobs
    puts 'Stopping rufus'
     Rufus::Scheduler.singleton.jobs(:tag => 'main_process').each do |job|
     Rufus::Scheduler.singleton.unschedule(job)
    end
    puts 'Starting rufus'
    load "#{Rails.root}/config/initializers/scheduler.rb"
  end

end
