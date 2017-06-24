class Api::V1::BidController < ApplicationController
  def index
    render 'index.json.jbuilder'
  end

  def show
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
