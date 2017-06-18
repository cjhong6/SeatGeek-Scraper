class BidController < ApplicationController

  #Get all the bids
  def index
    @bid = Bid.all
    render 'index.html.erb'
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
    bid = Bid.new(user_id: session[:user_id], lowest_price: params[:lowest_price], offer_price: params[:offer_price], event_name: params[:event_name])
    if bid.save
      flash[:success] = "New bid added"
    else
      flash[:danger] = "Fail adding bid"
    end
    redirect_to '/bids'
  end

  #update bid offer_price
  def update
    bid = Bid.find_by(id: params[:id])
    bid.offer_price = params[:offer_price]
    bid.save
    flash[:success] = "update bid successfully"
    redirect_to '/bids' 
  end

  #delete a bid
  def destroy
    @bid = Bid.find_by(id: params[:id])
    @bid.destroy
    flash[:success] = "destroy bid successfully"
    redirect_to '/bids'
  end

end
