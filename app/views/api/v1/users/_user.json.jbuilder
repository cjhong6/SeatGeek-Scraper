json.id user.id
json.username user.username
json.created_at user.created_at
json.bids user.bids.each do |bid|
  json.id bid.id
  json.event_name bid.event_name
  json.lowest_price bid.lowest_price.to_i
  json.offer_price bid.offer_price.to_i
  json.saved_bid bid.saved_bid.to_i
  json.created_at bid.created_at
  json.updated_at bid.updated_at
end