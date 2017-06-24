class Api::V1::EventsController < ApplicationController
  def index
    @responses = Unirest.get("https://api.seatgeek.com/2/events?geoip=136.0.16.217&range=20mi&datetime_utc.gte=2017-06-08&datetime_utc.lte=2017-07-08&listing_count.gt=0&client_id=Nzc0MTMyNHwxNDk2NTY5MTQzLjM0").body
    render 'index.json.jbuilder'
  end

  def show
    @response = Unirest.get("https://api.seatgeek.com/2/events/#{params[:id]}?&client_id=NjQwNTEzMXwxNDgxNDkxODI1").body
    render 'show.json.jbuilder'
  end

end
