# require 'twilio-ruby'

# # To find these visit https://www.twilio.com/user/account
# account_sid = "AC4d7b51eb3dcab7c8352169cdb40a2bb3"
# auth_token = "a7b52ca46178ff7834dc8a9ead766116"

# @client = Twilio::REST::Client.new account_sid, auth_token
# from = "16504885975",
# friends = {'13125501444' => "sam"}
# friends.each do |key, value|
# message = @client.messages.create(
#   :from => from,
#   :to => key,
#   :body => "Hey #{value}, This is cj. I made a program to send texts"
# )
# puts "sent message to #{value}"
# end