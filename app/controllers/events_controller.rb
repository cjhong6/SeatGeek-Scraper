class EventsController < ApplicationController
  #Get seatgeek events
  def index
    if params[:search].present?
     #return searched events
     title = params[:search]
     title.gsub! /\s+/, '-'
     @responses = Unirest.get("https://api.seatgeek.com/2/events?q=#{title}&client_id=NjQwNTEzMXwxNDgxNDkxODI1").body
    else
      #return all the events within 20 miles from SF
      @responses = Unirest.get("https://api.seatgeek.com/2/events?geoip=136.0.16.217&range=20mi&datetime_utc.gte=2017-06-08&datetime_utc.lte=2017-07-08&listing_count.gt=0&client_id=Nzc0MTMyNHwxNDk2NTY5MTQzLjM0").body
    end

    render 'index.html.erb'
  end

 #show deatiled info about the event
  def show
    @event = Unirest.get("https://api.seatgeek.com/2/events/#{params[:id]}?&client_id=NjQwNTEzMXwxNDgxNDkxODI1").body
    render 'show.html.erb'
  end

end
