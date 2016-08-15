require 'spec_helper'

describe LunchBot::Commands::Yelp do
  def app
    LunchBot::Bot.instance
  end

  # it 'returns successfully with food' do
  #   expect(message: "#{SlackRubyBot.config.user} food", channel: 'bot_testing').to_not respond_with_error
  # end
  #
  # it 'returns successfully with lunch' do
  #   expect(message: "#{SlackRubyBot.config.user} food", channel: 'bot_testing').to_not raise_error
  # end
  #
  # it 'allows user to pass a location' do
  #   expect(message: "#{SlackRubyBot.config.user} food location: 32828", channel: 'bot_testing').to_not raise_error
  # end
end
