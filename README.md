# LunchBot

LunchBot is a simple Slack bot to find lunch.

[![Build Status](https://travis-ci.org/chayelheinsen/LunchBot.svg?branch=master)](https://travis-ci.org/chayelheinsen/LunchBot)

# Getting Started
Requires Ruby 2.3.x

* Fork this repo or press the deploy to Heroku button below.
* Set up your `.env`. Take a look at `Environment Variables`.
* `bundle install`
* `bundle exec ruby lunch_bot.rb`

# Environment Variables

There are a few variables the app will require. You can take a look at the `.env.example` for an example of the available variables and how to set up your `.env`.
To set up the `.env`, touch a `.env` file, copy the contents of `.env.example` and fill it in with your information. You will need a [Slack API Token](http://slack.com/services/new/bot) and [Yelp Tokens](https://www.yelp.com/developers/manage_api_keys).

# Deploy to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/chayelheinsen/LunchBot/tree/master)
