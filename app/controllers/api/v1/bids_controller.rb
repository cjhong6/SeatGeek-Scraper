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
    render 'show.json.jbuilder'
  end

  def update
    render 'show.json.jbuilder'
  end

  def destroy
    render json: {message: "Bid sucessfully destroy"}
  end

end
