ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require 'dotenv/load'
require './app/controllers/application_controller'
require 'open-uri'
require 'net/http'
require_all 'app'
