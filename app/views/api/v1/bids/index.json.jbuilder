json.array! @bids.each do |bid|
  json.partial! 'bid.json.jbuilder', bid: bid
end