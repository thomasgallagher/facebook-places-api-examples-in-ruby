require 'net/http'
require 'json'

ACCESS_TOKEN = '[YOUR_ACCESS_TOKEN]'

def initialise_connection
  @http = Net::HTTP.new('graph.facebook.com', 443)
  @http.use_ssl = true
end

def pretty_print(json)
  puts JSON.pretty_generate(json)
end

def checkins
  pretty_print JSON.parse(@http.get("/me/checkins?access_token=#{ACCESS_TOKEN}").body)['data']
end

def checkin(id)
  pretty_print JSON.parse(@http.get("/#{id}?access_token=#{ACCESS_TOKEN}").body)
end

def friends_checkins(friend)
  pretty_print JSON.parse(@http.get("/#{friend}/checkins?access_token=#{ACCESS_TOKEN}").body)['data']
end

def check_in(message, place, longitude, latitude, tags)
  pretty_print JSON.parse(@http.post("/me/checkins?access_token=#{ACCESS_TOKEN}", "message=#{message}&place=#{place}&coordinates[longitude]=#{longitude}&coordinates[latitude]=#{latitude}&tags=#{tags.join(',')}").body)
end

def search_nearby(query, longitude, latitude, distance)
  pretty_print JSON.parse(@http.get("/search?access_token=#{ACCESS_TOKEN}&q=#{query}&type=place&center=#{latitude},#{longitude}&distance=#{distance}").body)
end

initialise_connection

# Uncomment one of the following lines to run the method
#   checkins
#   checkin('CHECKIN_ID')
#   friends_checkins('FRIEND_ID')
#   check_in('MESSAGE', 'PLACE', 'LONGITUDE', 'LATITIUDE', [FRIEND_ID, FRIEND ID])
#   search_nearby('QUERY', 'LONGITUDE', 'LATITIUDE', 'DISTANCE')