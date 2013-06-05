require 'rubygems'
require 'tweetstream'
require 'growl'


puts "searching for tegan and sara....should write to database"

TweetStream.configure do |config|
  config.consumer_key       = 'YX4uQcPXYbqhY0CTEee1cA'
  config.consumer_secret    = 'mDF4D1ui0OSIXP1dcT22YZRvD2lgDTAgqqN7jSBrk'
  config.oauth_token        = '216810199-xVkrhdy7WHynLO6ETbJjaJMPYAj58OyUbu3MklIg'
  config.oauth_token_secret = '1YHq62qtqdLTvBUF686gAPhjZHmawVRiE4Hdk9JV0'
  config.auth_method        = :oauth
end


# search for "teganandsara" and will print text and screen name while storing the other values in the database.
TweetStream::Client.new.track('teganandsara') do |status|
  puts status.text + " FROM: @" + status.user.screen_name
  Tweet.create(:user_id => status.user.id,
  				:tweet_text =>status.text, 
  				:screen_name =>status.user.screen_name)
end

@client = TweetStream::Client.new

@client.on_delete do |status_id, user_id|
  Tweet.delete(status_id)
end
