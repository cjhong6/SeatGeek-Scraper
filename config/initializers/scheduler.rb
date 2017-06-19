require 'rufus-scheduler'
require 'unirest'

# Let's use the rufus-scheduler singleton
#
scheduler = Rufus::Scheduler.singleton

puts "Starting rufus..."

# Recurrent task: check for lowest_price on events that are lower than the bid
scheduler.every '1h' do
  Rails.logger.info "hello, it's #{Time.now}"
  Rails.logger.flush
  Bid.all.each do | bid |
    id = bid.event_id
    @events = Unirest.get("https://api.seatgeek.com/2/events/#{id}?&client_id=NjQwNTEzMXwxNDgxNDkxODI1").body
    if @events["stats"]
       @low = @events["stats"]["lowest_price"]|| 0
        puts "Offer:$#{bid.offer_price}"
        puts "Lowes Price: $#{@low}"
       if @low < bid.offer_price.to_f
        BidPriceCheck.create(bid_id: bid.id, lowest_price: @low)
        puts "Match: #{@low} < $#{bid.offer_price}"
        bid.save
        puts "Bid save"
      else
        puts "Not match #{@low} > $#{bid.offer_price}"
      end
    end
  end
end