require 'spec_helper'

describe LunchBot::App do
  def app
    LunchBot::App.instance
  end

  it_behaves_like 'a slack ruby bot'
end
