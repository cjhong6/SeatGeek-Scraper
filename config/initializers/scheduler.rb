require 'rufus-scheduler'
require 'unirest'

# Let's use the rufus-scheduler singleton
#
scheduler = Rufus::Scheduler.singleton

puts "Starting rufus..."

# Recurrent task: check for lowest_price on events that are lower than the bid
scheduler.every '1d' do
  Rails.logger.info "hello, it's #{Time.now}"
  Rails.logger.flush
  Bid.all.each do | bid |
    id = bid.event_id

    @events = Unirest.get("https://api.seatgeek.com/2/events/#{id}?&client_id=NjQwNTEzMXwxNDgxNDkxODI1").body

    if @events["stats"]
       @low = @events["stats"]["lowest_price"]|| 0
       puts "Offer:$#{bid.offer_price}"
       puts "Bid ID #{bid.id}"
       puts "Lowes Price: $#{@low}"

       #create bid price check if not exist
       if BidPriceCheck.find_by(bid_id: bid.id).nil?
        BidPriceCheck.create(bid_id: bid.id, lowest_price: @low)
       end

       #get the latest lowest price from bid price check table
       bid_price_check = BidPriceCheck.where(bid_id: bid.id).last.lowest_price

       #if event not expired
       if @low != 0
         #create bid check price if new lowest_price not equal the old bid check price
         if @low != bid_price_check.to_f
          puts "$#{@low} != $#{bid_price_check}"
          BidPriceCheck.create(bid_id: bid.id, lowest_price: @low)
         end

         #update bid table
         if @low <= bid.offer_price.to_f
          puts "Match: #{@low} < $#{bid.offer_price}"
          bid.lowest_price = @low
          bid.save
          puts "Bid update"
        else
          puts "Not match #{@low} > $#{bid.offer_price}"
        end
      else
        puts "Event Expired"
      end
    end
  end
end