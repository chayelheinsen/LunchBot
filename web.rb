require 'sinatra/base'

module LunchBot
  class Web < Sinatra::Base
    get '/' do
      'LunchBot'
    end
  end
end
