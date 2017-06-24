require 'rufus-scheduler'
require 'unirest'
require 'twilio-ruby'

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
       if !Bid.find_by_id(bid.id).bid_price_check.any?
        BidPriceCheck.create(bid_id: bid.id, lowest_price: @low)
       end

       #get the latest lowest price from bid price check table
       bid_price_check = BidPriceCheck.where(bid_id: bid.id).last.lowest_price

       #event exist
       if @low != 0
         #create bid check price if new lowest_price not equal the old bid check price
         if @low != bid_price_check.to_f
          puts "$#{@low} != $#{bid_price_check}"
          BidPriceCheck.create(bid_id: bid.id, lowest_price: @low)
          send_message('4155137961', "Your offer $#{bid.offer_price} on #{bid.event_name} is now $#{@low} w/ bid id: #{bid.id}.")
         end

         #update bid table
         if @low <= bid.offer_price.to_f
          puts "Match: #{@low} < $#{bid.offer_price}"
          if bid.saved_bid.nil?            
            bid.lowest_price = @low
            bid.saved_bid = @low
            bid.save
            puts "Bid update"
            send_message('4155137961', "Match Your offer $#{bid.offer_price} on #{bid.event_name} is now $#{@low} w/ bid id: #{bid.id}!")
          end
        else
          puts "Not match #{@low} > $#{bid.offer_price}"
        end
      else #event expired
        if bid.saved_bid.nil?
          bid.saved_bid = @low
          bid.save
          BidPriceCheck.create(bid_id: bid.id, lowest_price: @low)
          send_message('4155137961', "Your #{bid.event_name} is expired w/ bid id: #{bid.id}.")
          puts "Event Expired"
        end
      end
    end
  end
end

def send_message(phone_number, alert_message)
  account_sid = "AC4d7b51eb3dcab7c8352169cdb40a2bb3"
  auth_token = "a7b52ca46178ff7834dc8a9ead766116"

      @client = Twilio::REST::Client.new account_sid, auth_token
      @twilio_number = "16504885975" 
      message = @client.messages.create(
        :from => @twilio_number,
        :to => phone_number,
        :body => alert_message
      )
      puts "sent message to #{message.to}"
end