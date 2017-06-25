class Api::V1::BidsController < ApplicationController
  def index
    @bids = Bid.all
    puts @bids
    render 'index.json.jbuilder'
  end

  def show
    @bid = Bid.find(params[:id])
    render 'show.json.jbuilder'
  end

  def create
    @bid = Bid.new(
      user_id: params[:user_id], 
      lowest_price: params[:lowest_price], 
      offer_price: params[:offer_price], 
      event_name: params[:event_name], 
      event_id: params[:event_id]
    )
    @bid.save
    render 'show.json.jbuilder'
  end

  def update
    @bid = Bid.find_by(id: params[:id])
    @bid.user_id = params[:user_id] || @bid.user_id
    @bid.lowest_price = params[:lowest_price] || @bid.lowest_price
    @bid.offer_price = params[:offer_price] || @bid.offer_price
    @bid.event_name = params[:event_name]|| @bid.event_name
    @bid.event_id = params[:event_id] || @bid.event_id
    @bid.save
    render 'show.json.jbuilder'
  end

  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy
    render json: {message: "Bid sucessfully destroy"}
  end

end
