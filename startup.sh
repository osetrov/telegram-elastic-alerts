#!/bin/bash
gem install sinatra
if [ "$RACK_ENV" == "production" ];
then
  bundle install
  ruby $MAIN_APP_FILE -p 5000
else
  bundle install
  if [ "$RACK_ENV" == "test" ];
  then
    rspec
  else
    gem install sinatra-contrib
    ruby $MAIN_APP_FILE -p 5000 -o '0.0.0.0'
  fi
fi