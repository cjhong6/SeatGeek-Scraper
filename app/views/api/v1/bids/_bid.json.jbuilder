json.bid bid
json.bid_price_check bid.bid_price_check.each do |checker|
  json.id checker.id
  json.lowest_price checker.lowest_price
  json.created_at checker.created_at
  json.updated_at checker.updated_at
end