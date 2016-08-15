require 'dotenv'
require 'slack-ruby-bot'
require 'yelp'
Dotenv.load

Yelp.client.configure do |config|
  config.consumer_key = ENV['YELP_CONSUMER_KEY']
  config.consumer_secret = ENV['YELP_CONSUMER_SECRET']
  config.token = ENV['YELP_TOKEN']
  config.token_secret = ENV['YELP_TOKEN_SECRET']
end

class Bot < SlackRubyBot::Bot
  match /((f|F)ood|(l|L)unch) ?((location:)(?<location>[a-zA-Z0-9_, ]*))?/ do |client, data, match|
    begin
      location = "32789"
      location = match[:location].split.join(" ") unless match[:location].blank?
      puts "Location: #{location}"
      result = Yelp.client.search(location, { term: 'food' })
      result = result.businesses[rand(0..result.businesses.length)]
      address = result.location.display_address.join(", ")
      # client.say(text: "I recommend `#{result.name}` at `#{address}`", channel: data.channel)

      client.web_client.chat_postMessage(
        channel: data.channel,
        as_user: true,
        attachments: [
              {
                fallback: "#{result.name} at #{address}",
                title: "#{result.name}",
                text: "#{address}",
                color: '#00FF00'
              }
            ]
      )
    rescue Yelp::Error::UnavailableForLocation => e
      client.web_client.chat_postMessage(
        channel: data.channel,
        as_user: true,
        attachments: [
              {
                fallback: "#{e} - If this is an address put in commas. i.e 1234 Some Road, Orlando, FL",
                title: "Opps! Something's not right.",
                text: "#{e} - If this is an address put in commas. i.e 1234 Some Road, Orlando, FL",
                color: '#FF0000'
              }
            ]
      )
    rescue Yelp::Error::MissingParameter => e
      client.web_client.chat_postMessage(
        channel: data.channel,
        as_user: true,
        attachments: [
              {
                fallback: "#{e}",
                title: "Opps! Something's not right.",
                text: "#{e}",
                color: '#FF0000'
              }
            ]
      )
    end

  end

  # command 'food' do |client, data, match|
  #   result = Yelp.client.search('32789', { term: 'food' })
  #   result.businesses.each do |biz|
  #     puts biz.name
  #   end
  #   client.say(text: "Here are some places near Teeps:", channel: data.channel)
  # end
end

Bot.run
