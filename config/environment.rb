ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'rubygems'
require 'pg'
require 'pathname'
require 'open-uri'
require 'uri'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'concurrent'
require 'twitter'
require 'fuzzy_match'
require 'amatch'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
CONFIG   = Pathname.new(File.expand_path("#{APP_ROOT}/config"))
APP_NAME = APP_ROOT.basename.to_s

Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

require APP_ROOT.join('config', 'database')   # db
require APP_ROOT.join('config', 'load_keys') # keys

# API stuff
T = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

CTA_KEY = ENV['CTA_API_KEY']
