require 'rufus-scheduler'
require 'unirest'

# Let's use the rufus-scheduler singleton
#
scheduler = Rufus::Scheduler.singleton

# Recurrent task: check for lowest_price on events that are lower than the bid
scheduler.every '5s' do
  bids = Bid.all

  bids.each do | bid |
    title = bid.event_name
    title.gsub! /\s+/, '-'

    puts title
    puts "Bid: #{bid.offer_price}"

    responses = Unirest.get("https://api.seatgeek.com/2/events?q=#{title}&client_id=NjQwNTEzMXwxNDgxNDkxODI1").body
    responses["events"].each do |event| 
      puts "#{event["stats"]["lowest_price"]}"

      if (event["stats"]["lowest_price"].to_i > 0) && (event["stats"]["lowest_price"] < bid.offer_price.to_i)
        bid.lowest_price = event["stats"]["lowest_price"]
        bid.save
        
        puts "$#{event["stats"]["lowest_price"]} is match to your bid"
      end
    end
  end
  Rails.logger.info "hello, it's #{Time.now}"
  Rails.logger.flush
end