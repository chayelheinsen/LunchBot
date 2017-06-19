module LunchBot
  module Commands
    class YelpCommands < SlackRubyBot::Commands::Base
      MATCH_REGEX = /(food|lunch) ?((location:)(?<location>[a-zA-Z0-9_, ]*))?/i

      match MATCH_REGEX do |client, data, match|
        begin
          location = ENV['DEFAULT_ZIP_CODE']&.to_s || "32789"
          location = match[:location].split.join(" ") unless match[:location].blank?
          puts "Location: #{location}"
          result = Yelp.client.search(location, { term: "food" })
          result = result.businesses[rand(0..result.businesses.length)]
          address = result.location.display_address.join(", ")

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
          YelpCommands.handle_location_error(client, data, e)
        rescue Yelp::Error::MissingParameter => e
          YelpCommands.handle_error(client, data, e)
        end

        private

        def self.handle_error(client, data, error)
          client.web_client.chat_postMessage(
            channel: data.channel,
            as_user: true,
            attachments: [
                  {
                    fallback: "#{error}",
                    title: "Opps! Something's not right.",
                    text: "#{error}",
                    color: '#FF0000'
                  }
                ]
          )
        end

        def self.handle_location_error(client, data, error)
          client.web_client.chat_postMessage(
            channel: data.channel,
            as_user: true,
            attachments: [
                  {
                    fallback: "#{error} - If this is an address put in commas. i.e 1234 Some Road, Orlando, FL",
                    title: "Opps! Something's not right.",
                    text: "#{error} - If this is an address put in commas. i.e 1234 Some Road, Orlando, FL",
                    color: '#FF0000'
                  }
                ]
          )
        end
      end
    end
  end
end
