json.array! @responses["events"].each do |response|
  json.partial! 'event.json.jbuilder', response: response
end