json.array!(@events) do |event|
  json.extract! event, :id
  json.title event.title + " " + event.user.private_name
  json.start event.start
  json.end event.end
end
