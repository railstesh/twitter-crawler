require 'nokogiri'
require 'open-uri'
require 'json'

doc = Nokogiri::HTML(open("https://twitter.com/esconsult1"))

object_array = doc.css("div.tweet.js-stream-tweet.js-actionable-tweet.js-profile-popup-actionable.original-tweet.js-original-tweet").collect do |node| 
	author_url = node.at_css("img.avatar.js-action-profile-avatar").attr('src')
	name = node.at_css("strong.fullname.js-action-profile-name.show-popup-with-id").text.strip
	user_name = node.at_css("span.username.js-action-profile-name b").text.strip
	times_tamp = node.at_css("div.stream-item-header small.time a.tweet-timestamp.js-permalink.js-nav.js-tooltip span._timestamp.js-short-timestamp").attr('data-time')
  body_text = node.at_css("div.js-tweet-text-container p.js-tweet-text.tweet-text").text.strip rescue "____tweet_text_not_available____"
  tweet_image = node.at_css("div.AdaptiveMedia.is-square div.AdaptiveMedia-container.js-adaptive-media-container div.AdaptiveMedia-singlePhoto div.AdaptiveMedia-photoContainer.js-adaptive-photo img").attr('src') rescue "____tweet_image_not_available____"
  {author_url: author_url, name: name, user_name: user_name, body_text: body_text, times_tamp: times_tamp, tweet_image: tweet_image}
end
json_obj = { json_data: object_array }

# Uncommment following for console output

puts ""
puts "Json Data"
puts ""
puts json_obj.to_json

puts ""
puts "Formated Data"
object_array.each do |obj|
	puts ""
	puts ""
	puts "author_url : " << obj[:author_url].to_s 
	puts "name       : " << obj[:name].to_s 
	puts "user_name  : " << obj[:user_name].to_s 
	puts "times_tamp : " << obj[:times_tamp].to_s 
	puts "tweet_image: " << obj[:tweet_image].to_s
	puts "body_text  : " << obj[:body_text].to_s
end
